as yet unclassified
writePacket: packet
	| buffer |
	
	buffer := packet write.
	session  write: buffer.
	