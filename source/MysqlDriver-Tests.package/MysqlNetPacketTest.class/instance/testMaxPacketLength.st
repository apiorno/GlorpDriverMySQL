Tests
testMaxPacketLength
	| pkt |

	pkt := MysqlNetPacket new.
	self assert: (pkt maxLength = 16rFFFFFF)
	