Testing
gotEof
	| resp |
	resp := MysqlPacket from: session peek.
	^ resp isEof 
	