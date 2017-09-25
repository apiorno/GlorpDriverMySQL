Actions
ddlTypeTestTables
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
		timestampValue timestamp,
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