Class {
	#name : #NativeMySQLConnectionPool,
	#superclass : #Object,
	#instVars : [
		'queue',
		'loginCredentials',
		'maxConnections',
		'logging'
	],
	#category : 'MySQLGlorpDriverModel'
}

{ #category : #Accessing }
NativeMySQLConnectionPool class >> nativeDriver [
	^NativeMySQLDriver
]

{ #category : #Api }
NativeMySQLConnectionPool >> acquireConnectionIfError: errorBlock [
      | connection |

	connection := self nextAvailableConnection.
	connection ifNil: [
		"All connections are stale and have been purged, grab some fresh ones"
		self connect: self loginCredentials. 
		connection := self nextAvailableConnection.
	].

	^ connection

]

{ #category : #Api }
NativeMySQLConnectionPool >> addConnection: aConnection [ 
	(aConnection notNil and: [aConnection isConnected])
	ifTrue: [
		self queue nextPut: aConnection
	]
	ifFalse:[
		self error: 'Attempting to add an invalid or closed connection to the pool'
	]
]

{ #category : #Executing }
NativeMySQLConnectionPool >> cleanPool [
	"flushes connections that have closed whilst idle in the pool"

	self queue flushAllSuchThat: [ :each | each isConnected not ]
]

{ #category : #'Connection-Pooling' }
NativeMySQLConnectionPool >> connect: aLogin [
	| nativeDriver connection size fillPoolSize|
	
	self loginCredentials: aLogin.

	size := self queue size.
	fillPoolSize := self maxConnections - size.

	1 to: fillPoolSize do:[:n |
		nativeDriver :=  self nativeDriver new. 
		connection := nativeDriver class connectionClass new.
		connection connect: (nativeDriver getDriverSpecFromLogin: aLogin).
		self addConnection: connection.
		self log: 'DBXPoolingDriver - Added one new connection to the Selma Pool. Connection # ',n asString.
	].

      
]

{ #category : #Logging }
NativeMySQLConnectionPool >> log: aStringOrBlock [
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
NativeMySQLConnectionPool >> logging [
	^ logging ifNil:[logging := false]
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> logging: anObject [
	logging := anObject
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> loginCredentials [
	^ loginCredentials
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> loginCredentials: anObject [
	loginCredentials := anObject
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> maxConnections [
	^ maxConnections ifNil:[maxConnections := 4]
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> maxConnections: anObject [
	maxConnections := anObject
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> nativeDriver [
	^ self class nativeDriver
]

{ #category : #'Connection-Pooling' }
NativeMySQLConnectionPool >> nextAvailableConnection [
	| connection |
	
	"Remove any stale connections in this pool"
	self cleanPool.

	[self queue isEmpty]
		whileFalse: [connection := self queue nextOrNil.
			(connection notNil and: [ connection isConnected ])
				ifTrue: [
					^ connection
			]
		].
	^ nil

]

{ #category : #Printing }
NativeMySQLConnectionPool >> printOn: aStream [ 
	super printOn: aStream.
	aStream
		nextPutAll: ' ( SelmaPool has ';
		print: self queue size;
		nextPutAll: ' used slots)'
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> queue [
	^ queue ifNil: [queue := SharedQueue new]
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> queue: anObject [ 
	queue := anObject
]

{ #category : #Executing }
NativeMySQLConnectionPool >> reset [
	"Removes and closes any connections in the pool"
	|connection|
	[self queue isEmpty]
		whileFalse: [connection := self queue nextOrNil.
			connection notNil 
				ifTrue: [
					connection isConnected ifTrue: [ connection terminate].
					connection := nil.
				]
		].
	queue := nil
]

{ #category : #Accessing }
NativeMySQLConnectionPool >> size [
	^ self queue size
]
