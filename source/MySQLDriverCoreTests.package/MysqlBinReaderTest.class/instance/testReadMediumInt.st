Tests
testReadMediumInt
	| aStream reader |
	aStream := ReadWriteStream on: ByteArray new.
	aStream
		nextPut: 16r41;
		nextPut: 16r13;
		nextPut: 16r64;
		nextPut: 16r00.
	aStream reset.
	reader := MysqlBinReader default.
	self assert: (reader mediumIntFrom: aStream) equals: 6558529