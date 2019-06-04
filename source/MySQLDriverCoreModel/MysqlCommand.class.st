Class {
	#name : #MysqlCommand,
	#superclass : #MysqlPacket,
	#instVars : [
		'command',
		'arg'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlCommand >> command: cmd arg: text [
	command := cmd.
	arg := text.
	
]

{ #category : #Writing }
MysqlCommand >> write [
	| buffStream |
	buffStream := WriteStream on: ByteArray new.
	buffStream nextPut: command.
	arg isEmptyOrNil ifFalse: [ buffStream nextPutAll: arg asByteArray ].
	^ buffStream contents
]
