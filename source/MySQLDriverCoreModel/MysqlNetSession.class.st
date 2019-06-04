Class {
	#name : #MysqlNetSession,
	#superclass : #Object,
	#instVars : [
		'theStream',
		'nextPacketNumber',
		'peekData'
	],
	#category : 'MySQLDriverCoreModel-Net'
}

{ #category : #Testing }
MysqlNetSession >> connected [
	^ theStream ifNil: [false] ifNotNil: [theStream isConnected] 
]

{ #category : #Executing }
MysqlNetSession >> disconnect [
	theStream isConnected ifTrue: [theStream close] .

]

{ #category : #Accessing }
MysqlNetSession >> getSequence [
	^ nextPacketNumber 
]

{ #category : #Initialization }
MysqlNetSession >> initialize [
	self resetSequence.

]

{ #category : #Reading }
MysqlNetSession >> peek [
	"Look ahead; don't remove the packet until next read"
	peekData ifNil: [peekData := self readPacketData].
	^ peekData
]

{ #category : #Reading }
MysqlNetSession >> read [
	| data |
	"Return packet from look ahead buffer if any. Clear look ahead buffer"
	peekData ifNotNil: [data := peekData. peekData := nil. ^ data].
	^ self readPacketData
	
]

{ #category : #Reading }
MysqlNetSession >> readNetPacket [
	| pkt |
	pkt := MysqlNetPacket new.
	pkt readFrom: theStream.
	self validatePacket: pkt.
	^ pkt
]

{ #category : #Reading }
MysqlNetSession >> readPacketData [
	"Read all packets until there is no more packets of data."
	| dataPackets pkt totalSize buffer ii |
	dataPackets := OrderedCollection new.
	
	[ pkt := self readNetPacket.
	dataPackets add: pkt ] doWhileTrue: [ pkt isOfMaxLength	"indicates more packets to follow" ].

	"Gather data from all packets and return. Avoid another copy where possible"
	dataPackets size = 1 ifTrue: [ ^ dataPackets first data ].	"only one pcaket"
	(dataPackets size = 2 and: [ dataPackets last length = 0 ]) 
		ifTrue: [ ^ dataPackets first data ].	"second packet is empty"
	"Multiple packets; put the data together before returning"
	totalSize := dataPackets inject: 0 into: [:total :each | total + each length].
	buffer := ByteArray new: totalSize.
	ii := 1.
	^ dataPackets 
		inject: buffer
		into: [ :result :packet | 
			result replaceFrom: ii to: (ii + packet length - 1) with: packet data startingAt: 1.
			ii := ii + packet length.
			result]
]

{ #category : #Accessing }
MysqlNetSession >> resetSequence [
	nextPacketNumber := 0
]

{ #category : #Accessing }
MysqlNetSession >> stream: aStream [
	theStream := aStream
	
]

{ #category : #Initialization }
MysqlNetSession >> toHost: host andPort: port [ 
	| aStream |
	self resetSequence.
	[aStream := SocketStream 
		openConnectionToHostNamed: host
		port: port.
	"Turn off Nagle algorithm, else response time to short packets would suffer. Thanks to
	Goran Krampe for studying the issue in Ubuntu linux and figure out the details. Ref:
	http://developers.slashdot.org/comments.pl?sid=174457&threshold=1&commentsort=0&mode=thread&cid=14515105 for comments from John Nagle himself."
	aStream socket setOption: 'TCP_NODELAY' value: true.
	aStream binary. 
	self stream: aStream] 
		on: NameLookupFailure 
		do: [:ex | MysqlNameLookupFailure signal: ex messageText] 
]

{ #category : #Updating }
MysqlNetSession >> updateSequence [
	nextPacketNumber := (nextPacketNumber + 1) bitAnd: 255
]

{ #category : #Reading }
MysqlNetSession >> validatePacket: pkt [
	"Validate a network packet unit. Currently we validate the sequence number."
	"Update sequence if validation passes"
	(self validateSequence: pkt number)
		ifTrue: [self updateSequence]
		ifFalse: [^ self error: 'Packet sequence validation error']
	
]

{ #category : #Testing }
MysqlNetSession >> validateSequence: pktNumber [ 
	^ pktNumber = nextPacketNumber
]

{ #category : #Writing }
MysqlNetSession >> write: data [ 
	self writePacketData: data

]

{ #category : #Writing }
MysqlNetSession >> writeNetPacket: pkt [
	"Write a network packet unit to the underlying stream".
	pkt writeTo: theStream
	
]

{ #category : #Writing }
MysqlNetSession >> writePacketData: data [ 
	| pkt nextPktStart dataLen |
	
	nextPktStart := 1.
	dataLen := data size.
	[	pkt := MysqlNetPacket new.
		pkt length: (dataLen min: pkt maxLength);
			number: self getSequence;
			data: (data copyFrom: nextPktStart  to: (nextPktStart + pkt length - 1)).
			
		self updateSequence.
		dataLen := dataLen - pkt length.
		nextPktStart := nextPktStart + pkt length.
		
		self writeNetPacket: pkt
	] doWhileTrue: [ pkt isOfMaxLength ]
]
