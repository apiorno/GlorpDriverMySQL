Class {
	#name : #NativeMySQLDriver,
	#superclass : #DatabaseDriver,
	#category : 'MySQLGlorpDriverModel'
}

{ #category : #Initialization }
NativeMySQLDriver class >> beGlorpDefaultDriver [
	(Smalltalk at: #PharoDatabaseAccessor) DefaultDriver: self .

]

{ #category : #'Glorp-API' }
NativeMySQLDriver >> basicExecuteSQLString: aString [
	| preparedRequest result rows emptyStream |
	emptyStream := ReadStream on: Array new.
	aString ifEmpty: [ ^ emptyStream ].
	preparedRequest := self prepare: aString.
	result := preparedRequest execute.
	result isResultSet
		ifFalse: [ ^ emptyStream ].
	rows := result rows collect: [ :each | each allValuesArrayed ].
	^ ReadStream on: rows asArray
]

{ #category : #'Glorp-API' }
NativeMySQLDriver >> beginTransaction [

	self query: 'START TRANSACTION'
]

{ #category : #'Glorp-API' }
NativeMySQLDriver >> commitTransaction [

	self query: 'COMMIT'
]

{ #category : #'Glorp-API' }
NativeMySQLDriver >> connect: aLogin [

	| connectionSpec |
	connection  := self connectionClass new. 
	connectionSpec := self getDriverSpecFromLogin: aLogin .
	connection connect: connectionSpec . 
	^ connection
]

{ #category : #'Glorp-API' }
NativeMySQLDriver >> connectionClass [

	^ MysqlDriver
]

{ #category : #private }
NativeMySQLDriver >> getDriverSpecFromLogin: aLogin [

	"connect string looks like  hostname:portNumber_db-name. :portNumber is optional"
	| connectionLine portIndex index dbIndex driverSpecs |
	connectionLine := aLogin connectString.
	portIndex := index := connectionLine indexOf: $:.
	dbIndex := connectionLine indexOf: $_.
	index = 0 ifTrue: [index := dbIndex].
	
	driverSpecs := (Dialect smalltalkAt: #MysqlDriverSpec) new
		host: (connectionLine copyFrom: 1 to: index - 1);
		port: (portIndex = 0 ifTrue: [3306] ifFalse: [(connectionLine copyFrom: portIndex + 1 to: dbIndex - 1) asNumber]);
		user: aLogin username;
		password: aLogin password;
		database: (connectionLine copyFrom: dbIndex + 1 to: connectionLine size) .
		
	^ driverSpecs
]

{ #category : #'Glorp-API' }
NativeMySQLDriver >> isConnected [

	^ connection connected
]

{ #category : #'Glorp-API' }
NativeMySQLDriver >> logout [

	connection disconnect .
]

{ #category : #private }
NativeMySQLDriver >> prepare: aString [

	| preparedRequest statementId statement |
	preparedRequest := connection prepare: aString .
	preparedRequest isError ifTrue: 
			[ Dialect error signal: preparedRequest message ].
	statementId := preparedRequest prepareOkay stmtHandlerId .
	statement := MysqlDriverStmt onConnection: connection.
	^statement stmtId: statementId .
]

{ #category : #private }
NativeMySQLDriver >> query: aString [
	| result |
	result := connection query: aString.
	result isError
		ifTrue: [ self error: result message ].
	^result
]

{ #category : #'Glorp-API' }
NativeMySQLDriver >> rollbackTransaction [

	self query: 'ROLLBACK'
]
