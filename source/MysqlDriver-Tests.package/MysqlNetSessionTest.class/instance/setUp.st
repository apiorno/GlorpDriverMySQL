Initialization
setUp
	session := MysqlNetSession new.
	ioStream := ReadWriteStream on: (ByteArray new). "test stream"
	ioStream binary; reset. 
	session stream: ioStream "inject test stream instead of using socket stream"
	