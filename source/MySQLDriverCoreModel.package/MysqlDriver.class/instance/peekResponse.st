private
peekResponse
	| buffer resp |
	
	buffer := netSession peek.
	resp := MysqlPacket from: buffer.
	^ resp
	