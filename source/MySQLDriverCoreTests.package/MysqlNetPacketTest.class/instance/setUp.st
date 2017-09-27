Initialization
setUp
	ioStream := ReadWriteStream on: (ByteArray new).
	ioStream binary; reset. 