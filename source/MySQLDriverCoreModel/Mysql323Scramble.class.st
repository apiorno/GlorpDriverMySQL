Class {
	#name : #Mysql323Scramble,
	#superclass : #MysqlPacket,
	#instVars : [
		'scrambleBuff',
		'password'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
Mysql323Scramble >> password: pwd [
	password := pwd
	
]

{ #category : #Accessing }
Mysql323Scramble >> scrambleBuff: scramble [
	scrambleBuff := scramble 
	
]

{ #category : #Writing }
Mysql323Scramble >> write [
	| scrmbl buffStream |
	buffStream := WriteStream on: (ByteArray new: 256).
	scrmbl := password isEmptyOrNil 
		ifTrue: [ '' asByteArray ]
		ifFalse: 	[ 
			MysqlHelper 
				scramble323: scrambleBuff
				with: password ].
	"Server expects just the scramble, null terminated and nothing else"
	buffStream nextPutAll: scrmbl.
	buffStream nextPut: 0.
	^ buffStream contents 
	
]
