Tests
testReadTinyInt
	| aStream reader |
	aStream := ReadWriteStream on: ByteArray new.
	aStream nextPut: 65.
	aStream reset.
	reader := MysqlBinReader default.
	self assert: (reader tinyIntFrom: aStream) equals: 65