Tests
testMaxPacketLength
	| pkt |
	pkt := MysqlNetPacket new.
	self assert: pkt maxLength equals: 16rFFFFFF