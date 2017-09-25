Tests
testReadFloat
	| aStream reader |
	aStream := ReadWriteStream on: ByteArray new.
	aStream nextPut: 16r00; nextPut: 16r00; nextPut: 16r82; nextPut: 16r42.
	aStream reset.
	
	reader := MysqlBinReader default.
	self assert: (reader floatFrom: aStream) = 65.0.
	