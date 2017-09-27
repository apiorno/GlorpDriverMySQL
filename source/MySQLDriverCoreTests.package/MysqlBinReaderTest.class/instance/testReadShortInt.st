Tests
testReadShortInt
	| aStream reader |
	aStream := ReadWriteStream on: ByteArray new.
	aStream
		nextPut: 65;
		nextPut: 2.
	aStream reset.
	reader := MysqlBinReader default.
	self assert: (reader smallIntFrom: aStream) equals: 577