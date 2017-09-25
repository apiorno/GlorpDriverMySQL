Tests
testBytesFromHexString
	| bytes |
	bytes := MysqlHelper bytesFromHexString: '00112233445566778899AABBCCDDEEFF'.
	self assert: (bytes first) = 0.
	self assert: (bytes at: 8) = 119.
	self assert: (bytes at: 16) = 255.
	