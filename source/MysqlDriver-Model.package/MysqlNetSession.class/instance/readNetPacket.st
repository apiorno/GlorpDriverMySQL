reading
readNetPacket
	| pkt |
	pkt := MysqlNetPacket new.
	pkt readFrom: theStream.
	self validatePacket: pkt.
	^ pkt