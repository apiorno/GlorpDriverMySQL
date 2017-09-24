as yet unclassified
gotEof
	^ (MysqlPacket from: session peek) isEof 
	