Class {
	#name : #NativeMySQLPoolingDriver,
	#superclass : #NativeMySQLDriver,
	#instVars : [
		'isInTransaction',
		'loginCredentials',
		'logging'
	],
	#classVars : [
		'SelmaPools'
	],
	#category : 'MySQLGlorpDriverModel'
}

{ #category : #Accessing }
NativeMySQLPoolingDriver class >> nativeConnectionPool [
	^NativeMySQLConnectionPool


]

{ #category : #Accessing }
NativeMySQLPoolingDriver class >> poolFor: aLogin [
	"Get the appropriate connection pool - one per set of logins"
	^ self selmaPools
		"DO NOT use aLogin here as the key because it's #= checks for equal password. And if password are cleaned because
		passwords are discarded (connections are secure), this gives false. So if we want to use aLogin for key, they have to be 
		set secure: false. For this purpose we use #connectString."
		at: aLogin connectString
		ifAbsentPut: [ self nativeConnectionPool new ] 


]

{ #category : #Executing }
NativeMySQLPoolingDriver class >> resetAllPools [
	self selmaPools valuesDo: [ :each | each reset ].
	SelmaPools := nil.
]

{ #category : #Accessing }
NativeMySQLPoolingDriver class >> selmaPools [
	SelmaPools ifNil:[ self selmaPools: Dictionary new].
	^ SelmaPools
]

{ #category : #Accessing }
NativeMySQLPoolingDriver class >> selmaPools: aDictionary [
	SelmaPools := aDictionary
]

{ #category : #'Connection-Pooling' }
NativeMySQLPoolingDriver >> acquireConnection [
	^ self acquireConnectionIfError: [:error | error pass]
]

{ #category : #'Connection-Pooling' }
NativeMySQLPoolingDriver >> acquireConnectionIfError: errorBlock [
	(connection notNil and: [ connection isConnected]) ifTrue: [ ^ connection ].
	^ self connectionPool acquireConnectionIfError: errorBlock.
]

{ #category : #'Connection-Pooling' }
NativeMySQLPoolingDriver >> basicExecuteSQLString: aString [
	^ self withConnectionDo: [ super basicExecuteSQLString: aString]
]

{ #category : #Transactions }
NativeMySQLPoolingDriver >> beginTransaction [
	isInTransaction := true.
	connection ifNil:[
		connection:=self acquireConnection
	].
	super beginTransaction.	
	self log: 'DBXPoolingDriver - has started a transaction'


]

{ #category : #Transactions }
NativeMySQLPoolingDriver >> commitTransaction [
	isInTransaction := false.
	[super commitTransaction] ensure:[self releaseConnection].
	self log: 'DBXPoolingDriver - has committed a transaction $'

]

{ #category : #'Connection-Pooling' }
NativeMySQLPoolingDriver >> connect: aLogin [

	self loginCredentials: aLogin.
	self connectionPool connect: aLogin.
	connection:= self acquireConnection.
]

{ #category : #'Connection-Pooling' }
NativeMySQLPoolingDriver >> connectionPool [
	"Get the appropriate connection pool - one per set of logins"
	^ self class poolFor: self loginCredentials 
		
]

{ #category : #Initialize }
NativeMySQLPoolingDriver >> initialize [
	super initialize.
	isInTransaction := false.

]

{ #category : #'Connection-Pooling' }
NativeMySQLPoolingDriver >> isConnected [
	^ true
]

{ #category : #Transactions }
NativeMySQLPoolingDriver >> isInTransaction [
	^connection notNil and: [isInTransaction]
]

{ #category : #Logging }
NativeMySQLPoolingDriver >> log: aStringOrBlock [
	"Log an arbitrary string"
	| string |
	self logging ifFalse: [^self].
	string := aStringOrBlock isString
		ifTrue: [aStringOrBlock]
		ifFalse: [aStringOrBlock value].
	string size > 4000 ifTrue: [string := string copyFrom: 1 to: 4000].
	Transcript
		cr;
		show: string.
]

{ #category : #Accessing }
NativeMySQLPoolingDriver >> logging [
	^ logging ifNil:[logging := false]
]

{ #category : #Accessing }
NativeMySQLPoolingDriver >> logging: anObject [
	logging := anObject
]

{ #category : #Accessing }
NativeMySQLPoolingDriver >> loginCredentials [
	^ loginCredentials
]

{ #category : #Accessing }
NativeMySQLPoolingDriver >> loginCredentials: anObject [
	loginCredentials := anObject
]

{ #category : #Login }
NativeMySQLPoolingDriver >> logout [
	self log: 'DBXPoolingDriver - logging out'.
	self connectionPool reset
	

]

{ #category : #Printing }
NativeMySQLPoolingDriver >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPutAll: ' loginCredentials: ';
		print: loginCredentials.
	aStream
		nextPutAll: ' isInTransaction: ';
		print: isInTransaction.
	aStream
		nextPutAll: ' logging: ';
		print: logging.
	aStream
		nextPutAll: ' connection: ';
		print: connection.
	"aStream
		nextPutAll: ' maxConnections: ';
		print: maxConnections.
	aStream
		nextPutAll: ' database: ';
		print: database"
]

{ #category : #'Connection-Pooling' }
NativeMySQLPoolingDriver >> releaseConnection [

	connection ifNil:[
		self error: 'DBXPoolingDriver - ERROR Releasing the connection, but its already nil ERROR'.
		^ self.
	].

	connection ifNotNil:[
		self isInTransaction ifTrue:[
			self error: 'DBXPoolingDriver -- Returning a connection that has an open Transaction '.
			^ self
			"self commitTransaction"
		].
		
		"Connection cleanUp."
		self connectionPool addConnection: connection.
		self log: 'DBXPoolingDriver - Connection is returned  to pool and setting current pointer to nil '.
		connection := nil
	]
]

{ #category : #Transactions }
NativeMySQLPoolingDriver >> rollbackTransaction [
	isInTransaction := false.
	[super rollbackTransaction] ensure:[self releaseConnection]. 
	self log: 'DBXPoolingDriver - has rolled back  a transaction'
]

{ #category : #'Connection-Pooling' }
NativeMySQLPoolingDriver >> withConnectionDo: aBlock [
	connection isNil
		ifTrue: [ connection := self acquireConnection ].

	"If we are in a transaction, then we should not release the connection here, rather wait for the commit or rollback to release it"
	isInTransaction
		ifTrue: [ ^ aBlock value ].
	^ [ aBlock value ]
		ensure: [ self releaseConnection ]
]
