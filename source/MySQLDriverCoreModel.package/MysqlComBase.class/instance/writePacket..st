Writing
writePacket: packet
	| buffer |
	
	buffer := packet write.
	session  write: buffer.
	