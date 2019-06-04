Class {
	#name : #MysqlComChangeUser,
	#superclass : #MysqlComBase,
	#instVars : [
		'user',
		'password',
		'database',
		'charset',
		'scrambleBuff',
		'scrambledPassword'
	],
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComChangeUser >> charset: cset [ 
	charset := cset
]

{ #category : #Accessing }
MysqlComChangeUser >> commandArg [
	| buffStream |
	buffStream := WriteStream on: ByteArray new.
	buffStream
		nextPutAll: user asByteArray;
		nextPut: 0.
	MysqlPacket new 
		encodeLcs: scrambledPassword asByteArray
		on: buffStream.
	buffStream
		nextPutAll: (database 
				ifNil: [ '' asByteArray ]
				ifNotNil: [ database asByteArray ]);
		nextPut: 0.
	buffStream
		nextPut: (charset digitAt: 1);
		nextPut: (charset digitAt: 2).
	^ buffStream contents
]

{ #category : #Accessing }
MysqlComChangeUser >> commandCode [
	^ ComChangeUser 
]

{ #category : #Accessing }
MysqlComChangeUser >> database: dbName [
	database := dbName
]

{ #category : #Accessing }
MysqlComChangeUser >> password: pwd [
	password := pwd
]

{ #category : #Reading }
MysqlComChangeUser >> readResponse [
	| pkt |

	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [^ pkt].
		
	pkt isEof ifTrue: [
		"Absorb the response"
		session read.
		"For old (short) hash style passwords"
		self send323Scramble.
		pkt := super readResponse.
		pkt isOkayOrError 
			ifTrue: [^ pkt]].
		
	MysqlDriverError signal: 'Unrecognized response for command'
	
]

{ #category : #Accessing }
MysqlComChangeUser >> scrambleBuff: seed [
	scrambleBuff := seed
	
]

{ #category : #Accessing }
MysqlComChangeUser >> scrambledPassword: pwd [
	scrambledPassword := pwd
	
]

{ #category : #Accessing }
MysqlComChangeUser >> send323Scramble [
	| scrmblPkt |
	scrmblPkt := Mysql323Scramble new.
	scrmblPkt password: password; scrambleBuff: scrambleBuff.
	self writePacket: scrmblPkt
	
]

{ #category : #Accessing }
MysqlComChangeUser >> user: userName [
	user := userName
]
