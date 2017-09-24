private
readResponse
	| buffer resp |
	
	buffer := netSession read.
	resp := MysqlPacket from: buffer.
	^ resp