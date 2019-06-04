Class {
	#name : #MysqlNetPacketTest,
	#superclass : #TestCase,
	#instVars : [
		'ioStream'
	],
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #Initialization }
MysqlNetPacketTest >> setUp [
	ioStream := ReadWriteStream on: (ByteArray new).
	ioStream binary; reset. 
]

{ #category : #Tests }
MysqlNetPacketTest >> testMaxLength [
	self assert: MysqlNetPacket maxLength equals: 16rFFFFFF.
	self assert: MysqlNetPacket new maxLength equals: 16rFFFFFF
]

{ #category : #Tests }
MysqlNetPacketTest >> testMaxLengthWriteRead [
	| pktData outPkt inPkt |
	"write packet of max possible size"
	pktData := ByteArray new: 16rFFFFFF withAll: 16rAA.
	outPkt := MysqlNetPacket new.
	outPkt
		number: 16rFF;
		data: pktData;
		length: pktData size.
	outPkt writeTo: ioStream.

	"read back"
	ioStream reset.
	inPkt := MysqlNetPacket new.
	inPkt readFrom: ioStream.
	self assert: inPkt isOfMaxLength.
	self assert: inPkt number equals: 16rFF.
	self assert: (inPkt data hasEqualElements: outPkt data)
]

{ #category : #Tests }
MysqlNetPacketTest >> testMaxPacketLength [
	| pkt |
	pkt := MysqlNetPacket new.
	self assert: pkt maxLength equals: 16rFFFFFF
]

{ #category : #Tests }
MysqlNetPacketTest >> testPacketWriteRead [
	| outPkt inPkt pktData |
	"Write packet to stream"
	pktData := Character alphabet asByteArray.
	outPkt := MysqlNetPacket new.
	outPkt
		length: 26;
		number: 0;
		data: pktData.
	outPkt writeTo: ioStream.

	"Read it back"
	ioStream reset.
	inPkt := MysqlNetPacket new.
	inPkt readFrom: ioStream.
	self assert: inPkt length equals: 26.
	self assert: inPkt number equals: 0.
	self assert: inPkt data equals: pktData
]

{ #category : #Tests }
MysqlNetPacketTest >> testValidateLengthOnWrite [
	| pktData outPkt |
	pktData := Character alphabet asByteArray.
	outPkt := MysqlNetPacket new.
	outPkt
		length: 25;
		number: 0;
		data: pktData.
	self should: [ outPkt writeTo: ioStream ] raise: Error.
	outPkt length: 27.
	self should: [ outPkt writeTo: ioStream ] raise: Error.
	outPkt length: 26.
	outPkt writeTo: ioStream
]
