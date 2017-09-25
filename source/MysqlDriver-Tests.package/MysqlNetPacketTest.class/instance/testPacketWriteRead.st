Tests
testPacketWriteRead
	| outPkt inPkt pktData |
	
	"Write packet to stream"
	pktData := Character alphabet asByteArray.
	outPkt := MysqlNetPacket new.
	outPkt length: 26; number: 0; data: pktData.
	outPkt writeTo: ioStream.

	"Read it back"
	ioStream reset.
	inPkt := MysqlNetPacket new.
	inPkt readFrom: ioStream.
	
	self assert: (inPkt length = 26).
	self assert: (inPkt number = 0).
	self assert: (inPkt data = pktData)
	