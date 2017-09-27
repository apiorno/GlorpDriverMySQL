private
writePacket: packet
	| buffer |
	
	buffer := packet write.
	netSession  write: buffer.
