Testing
gotEof
	^ (MysqlPacket from: session peek) isEof 
