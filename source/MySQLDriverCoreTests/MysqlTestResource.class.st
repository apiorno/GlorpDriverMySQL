"
MySQL general resource for tests
"
Class {
	#name : #MysqlTestResource,
	#superclass : #TestResource,
	#instVars : [
		'conn',
		'testConn'
	],
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #Accessing }
MysqlTestResource class >> alternativeUsername [
	^ 'test'
]

{ #category : #Accessing }
MysqlTestResource class >> dbName [
	^ 'sodbxtest'
]

{ #category : #Accessing }
MysqlTestResource class >> driverSpecNoDb [
	^ MysqlDriverSpec new
		host: 'localhost';
		port: 3306;
		user: 'root';
		password: '';
		yourself
]

{ #category : #Accessing }
MysqlTestResource class >> driverSpecWithDb [
	^ self driverSpecNoDb
		db: self dbName;
		yourself
		
]

{ #category : #Actions }
MysqlTestResource >> clearTestTables [
	#(
	'nameValue' 'warn' 'mix' 'testMisc' 'testIntegers' 'testReals' 'testTimes' 'testChars'
	'testBinaries' 'testBlobs' 'testTexts') 
		do: [:each | conn query: 'truncate table ', each]

]

{ #category : #Connection }
MysqlTestResource >> connectToServer [
	| resp |
	conn := MysqlDriver new.
	resp := conn connect: self class driverSpecNoDb.
	resp isOkay 
		ifFalse: [ ^ self error: 'Failed to connect to MySQL server' ]
]

{ #category : #Accessing }
MysqlTestResource >> connectionForTest [
	"Returns a connection to be used for the testXyz methods. 
	Not to be confused with the internal connection instance 
	for setting up schemas and tables"
	(testConn isNil or: [ testConn connected not ]) 
		ifTrue: [
			testConn := MysqlDriver new.
			testConn connect: self class driverSpecWithDb].
	^ testConn
]

{ #category : #Actions }
MysqlTestResource >> createAlternativeUser [
	"Creates an aalternative user with the same password as the main test user"
	| resp |
	resp := conn query: 'CREATE USER ''', self class alternativeUsername , '''@''%''IDENTIFIED BY ''', self class driverSpecNoDb password , ''';'.
	resp isOkay ifFalse: [^ self error: 'Can not create second user'].
]

{ #category : #Actions }
MysqlTestResource >> createMiscTestTables [
	| resp |
	self ddlMiscTestTables do: [:each |
		resp := conn query: each.
		resp isError ifTrue: [^ self error: 'Error creating misc test table: ', resp message]]
	
]

{ #category : #Actions }
MysqlTestResource >> createTestDb [
	| resp |
	resp := conn query: 'create database if not exists ', self class dbName, ' DEFAULT CHARACTER SET latin1'.
	resp isOkay ifFalse: [^ self error: 'Can not create test database'].
	
	resp := conn query: 'use ', self class dbName.
	resp isError ifTrue: [^ self error: 'Failed to use test database'].	

]

{ #category : #Actions }
MysqlTestResource >> createTypeTestTables [
	| resp |
	self ddlTypeTestTables do: [:each |
		resp := conn query: each.
		resp isError ifTrue: [^ self error: 'Error creating type test table: ', resp message]]
	
]

{ #category : #Actions }
MysqlTestResource >> ddlMiscTestTables [
	^ #(
	'create table if not exists nameValue (
		id int not null auto_increment primary key,
		name varchar(256) not null unique key,
		value varchar(1024) not null default ''aeiou''
	) engine = InnoDB'
	
	'/* for testing warnings */
	create table if not exists warn (
		c1 tinyint not null,
		c2 varchar(32)
	)'

	'create table if not exists mix (
		name varchar(256) not null primary key,
		value decimal(21,9) default null
	) engine = InnoDB'
		
	'create table if not exists testMisc (
		name varchar(100) not null primary key,
		value varchar(1000) not null,
		entryOn date not null,
		notes varchar(1000)
	) engine = InnoDB'
	
	'create table if not exists testWideTable (
		id int auto_increment not null primary key,
		name varchar(100),
		shortDescription varchar(200),
		longDescription varchar(1000),
		categotyCode int,
		categoryName varchar(200),
		supplierCode int,
		supplierName varchar(200),
		colorCode int,
		colorName varchar(100),
		colorSource int,
		colorSourceName varchar(100),
		size int,
		attributeA varchar(100),
		attributeB varchar(100),
		attributeC varchar(100),
		attributeD varchar(100),
		attributeE varchar(100),
		attributeF varchar(100),
		attributeG varchar(100),
		attributeH varchar(100),
		attributeI varchar(100),
		attributeJ varchar(100),
		attributeK varchar(100),
		attributeL varchar(100),
		attributeM varchar(100),
		attributeN varchar(100),
		attributeO varchar(100),
		attributeP varchar(100),
		attributeQ varchar(100),
		attributeR varchar(100),
		attributeS varchar(100),
		attributeT varchar(100),
		attributeU varchar(100),
		attributeV varchar(100),
		attributeW varchar(100),
		attributeX varchar(100),
		attributeY varchar(100),
		attributeZ varchar(100)
	) engine = InnoDB'
	)
]

{ #category : #Actions }
MysqlTestResource >> ddlTypeTestTables [
	^ #(
	
	'create table if not exists testIntegers (
		id int auto_increment primary key,
		tinyintValue tinyint,
		smallintValue smallint,
		mediumintValue mediumint,
		intValue int,
		bigintValue bigint
	) engine = InnoDB'
	
	'create table if not exists testReals (
		id int auto_increment primary key,
		floatValue float,
		doubleValue double,
		realValue real,
		decimalValue decimal(10,6),
		numericValue numeric(10, 6)
	) engine = InnoDB'
	
	'create table if not exists testTimes (
		id int auto_increment primary key,
		dateValue date,
		timeValue time,
		datetimeValue datetime,
		yearValue year
	) engine = InnoDB'
	
	'create table if not exists testChars (
		id int auto_increment primary key,
		charValue char(100),
		varcharValue varchar(1000)
	) engine = InnoDB'
	
	'create table if not exists testBinaries (
		id int auto_increment primary key,
		binaryValue binary,
		varbinaryValue varbinary(256)
	) engine = InnoDB'
	
	'create table if not exists testBlobs (
		id int auto_increment primary key,
		tinyblobValue tinyblob,
		blobValue blob,
		mediumblobValue mediumblob,
		longblobValue longBlob
	) engine = InnoDB'
	
	'create table if not exists testTexts (
		id int auto_increment primary key,
		tinytextValue tinytext,
		textValue text,
		mediumtextValue mediumtext,
		longtextValue longtext
	) engine = InnoDB'
	
	)
]

{ #category : #Actions }
MysqlTestResource >> deleteAlternativeUser [
	| resp |
	resp := conn query: 'DROP USER ''', self class alternativeUsername, ''';'.
	resp isOkay ifFalse: [^ self error: 'Can not create second user'].
]

{ #category : #Actions }
MysqlTestResource >> deleteTestDb [
	| resp |
	resp := conn query: 'drop database if exists ', self class dbName.
	resp isOkay ifFalse: [^ self error: 'Can not create test database']	
]

{ #category : #Connection }
MysqlTestResource >> disconnecTestConnection [
	testConn ifNotNil:[
		[testConn disconnect] on: MysqlNoConnectionError do: [:ex |ex resume]]

]

{ #category : #Connection }
MysqlTestResource >> disconnectFromServer [
	[conn disconnect] on: MysqlNoConnectionError do: [:ex |ex resume].

]

{ #category : #Accessing }
MysqlTestResource >> resourceConnection [
	^ conn
	
]

{ #category : #Initialization }
MysqlTestResource >> setUp [
	self 
		connectToServer;
		createTestDb;
		createAlternativeUser;
		createMiscTestTables;
		createTypeTestTables.
		
]

{ #category : #Finalization }
MysqlTestResource >> tearDown [
	self disconnecTestConnection.	
	self deleteTestDb.
	self deleteAlternativeUser.
	self disconnectFromServer.

]
