Class {
	#name : #MysqlNetPacket,
	#superclass : #Object,
	#instVars : [
		'length',
		'number',
		'data'
	],
	#classVars : [
		'MaxPacketLength'
	],
	#category : 'MySQLDriverCoreModel-Net'
}

{ #category : #Initialization }
MysqlNetPacket class >> initialize [
	"self initialize"
	MaxPacketLength := 16rFFFFFF.

]

{ #category : #Defaults }
MysqlNetPacket class >> maxLength [
	^ MaxPacketLength
]

{ #category : #Accessing }
MysqlNetPacket >> data [
	^ data
]

{ #category : #Accessing }
MysqlNetPacket >> data: buffer [ "should be ByteArray"
	data := buffer
]

{ #category : #Testing }
MysqlNetPacket >> isOfMaxLength [
	^ length = MaxPacketLength
]

{ #category : #Accessing }
MysqlNetPacket >> length [
	^ length 
]

{ #category : #Accessing }
MysqlNetPacket >> length: size [
	length := size
]

{ #category : #Accessing }
MysqlNetPacket >> maxLength [
	^ MaxPacketLength
]

{ #category : #Accessing }
MysqlNetPacket >> number [
	^ number
]

{ #category : #Accessing }
MysqlNetPacket >> number: num [
	number := num
]

{ #category : #Reading }
MysqlNetPacket >> readFrom: aStream [
	length := aStream next + (aStream next << 8) + (aStream next << 16).
	number := aStream next.
	data := aStream next: length.
]

{ #category : #Writing }
MysqlNetPacket >> writeTo: aStream [
	length = data size ifFalse: [self error: 'Mismatch between packet length and data size'].

	aStream 
		nextPut: (length digitAt: 1);
		nextPut: (length digitAt: 2);
		nextPut: (length digitAt: 3).
		
	aStream nextPut: (number digitAt: 1)	.
	
	(aStream respondsTo: #nextPutAllFlush:)  "socket streams respond to this"
		ifTrue: [aStream nextPutAllFlush: data] "this one avoids some data copy"
		ifFalse: [aStream nextPutAll: data; flush]
]
