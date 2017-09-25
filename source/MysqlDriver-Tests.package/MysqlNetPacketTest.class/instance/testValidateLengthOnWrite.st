Tests
testValidateLengthOnWrite
	| pktData outPkt |
	pktData := Character alphabet asByteArray.
	outPkt := MysqlNetPacket new.
	outPkt
		length: 25;
		number: 0;
		data: pktData.
	self 
		should: [ outPkt writeTo: ioStream ]
		raise: Error.
	outPkt length: 27.
	self 
		should: [ outPkt writeTo: ioStream ]
		raise: Error.
	outPkt length: 26.
	self 
		shouldnt: [ outPkt writeTo: ioStream ]
		raise: Error