Tests
testMaxLengthWriteRead
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