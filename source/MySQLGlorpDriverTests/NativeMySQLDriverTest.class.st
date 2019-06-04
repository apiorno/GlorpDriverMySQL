Class {
	#name : #NativeMySQLDriverTest,
	#superclass : #GlorpMainBackendTest,
	#instVars : [
		'connection'
	],
	#category : 'MySQLGlorpDriverTests'
}

{ #category : #Accessing }
NativeMySQLDriverTest class >> glorpBackendFacility [
	| facility |
	facility := GlorpBackendFacility new.
	facility login: self login.
	^ facility
]

{ #category : #Accessing }
NativeMySQLDriverTest class >> login [
	^Login new
		database: self platform new;
		username: 'root';
		password: '';
		connectString: 'localhost_sodbxtest'
]

{ #category : #Accessing }
NativeMySQLDriverTest class >> nativeDriver [
	^NativeMySQLDriver
]

{ #category : #Accessing }
NativeMySQLDriverTest class >> platform [
	^MySQLPlatform
]

{ #category : #Tests }
NativeMySQLDriverTest >> connectionForTest [
	self assert: connection isConnected
]

{ #category : #Initialization }
NativeMySQLDriverTest >> setUp [
	connection := self class nativeDriver new .
	connection connect: self class login .
]

{ #category : #Tests }
NativeMySQLDriverTest >> testQueryPharoObjectInteger [
	| result |
	result := connection basicExecuteSQLString: 'select 1' .
	self assert: (result next includes: 1)
]

{ #category : #Tests }
NativeMySQLDriverTest >> testQueryPharoObjectString [
	| result |
	result := connection basicExecuteSQLString: 'select UPPER("yolo")' .
	self assert: (result next includes: 'YOLO')
]

{ #category : #Tests }
NativeMySQLDriverTest >> testQueryWhithoutReturn [
	| result |
	result := connection basicExecuteSQLString: '' .
	self assert: (result isEmpty)
]

{ #category : #Tests }
NativeMySQLDriverTest >> testSetToBaseTestAFacility [
	super testSetToBaseTestAFacility.
	PharoDatabaseAccessor DefaultDriver: self class nativeDriver.
	GlorpDatabaseLoginResource current: nil.
	GlorpDatabaseLoginResource defaultLogin: self class glorpBackendFacility login
]
