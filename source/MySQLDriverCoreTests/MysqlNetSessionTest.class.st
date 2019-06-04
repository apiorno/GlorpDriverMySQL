Class {
	#name : #MysqlNetSessionTest,
	#superclass : #TestCase,
	#instVars : [
		'session',
		'ioStream',
		'maxLen'
	],
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #Initialization }
MysqlNetSessionTest >> initialize [
	maxLen := MysqlNetPacket maxLength.

]

{ #category : #'Test Support' }
MysqlNetSessionTest >> maxLen [
	^maxLen 
]

{ #category : #Initialization }
MysqlNetSessionTest >> setUp [
	session := MysqlNetSession new.
	ioStream := ReadWriteStream on: (ByteArray new). "test stream"
	ioStream binary; reset. 
	session stream: ioStream "inject test stream instead of using socket stream"
	
]

{ #category : #Tests }
MysqlNetSessionTest >> testBigSizeReadWrite [
	| pktData |
	
	pktData := ByteArray new: self maxLen * 2 + (self maxLen >> 8) withAll: 16rAA.
	self verifyWriteFollowedByReadForData: pktData	
]

{ #category : #Tests }
MysqlNetSessionTest >> testLessThanMaxSizeReadWrite [
	| pktData |
	
	pktData := ByteArray new: self maxLen >> 8 withAll: 16rAA.
	self verifyWriteFollowedByReadForData: pktData	
]

{ #category : #Tests }
MysqlNetSessionTest >> testMaxSizeReadWrite [
	| pktData |
	
	pktData := ByteArray new: self maxLen withAll: 16rAA.
	self verifyWriteFollowedByReadForData: pktData	
]

{ #category : #Tests }
MysqlNetSessionTest >> testSequenceNumbering [
	self
		assert: session getSequence = 0
		description: '0 right after creation'.
	self assert: (session validateSequence: 0).
	session updateSequence.
	self assert: session getSequence equals: 1.
	self assert: (session validateSequence: 1).
	255 timesRepeat: [ session updateSequence ].
	self assert: session getSequence = 0 description: 'Modulo 256'.
	self assert: (session validateSequence: 0).
	10 timesRepeat: [ session updateSequence ].
	self assert: session getSequence equals: 10.
	self assert: (session validateSequence: 10).
	session resetSequence.
	self assert: session getSequence equals: 0.
	self assert: (session validateSequence: 0)
]

{ #category : #Asserting }
MysqlNetSessionTest >> verifyWriteFollowedByReadForData: writeData [
	| readData |
	session write: writeData.
	ioStream reset.
	session resetSequence.
	readData := session readPacketData.
	self assert: readData size equals: writeData size.
	self assert: (readData hasEqualElements: writeData)
]
