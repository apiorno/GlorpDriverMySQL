Tests
testBytesFromHexString
	| bytes |
	bytes := MysqlHelper
		bytesFromHexString: '00112233445566778899AABBCCDDEEFF'.
	self assert: bytes first equals: 0.
	self assert: (bytes at: 8) equals: 119.
	self assert: (bytes at: 16) equals: 255