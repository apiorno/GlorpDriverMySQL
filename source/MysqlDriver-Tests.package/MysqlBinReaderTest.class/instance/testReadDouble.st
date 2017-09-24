as yet unclassified
testReadDouble
	| aStream reader |
	aStream := ReadWriteStream on: ByteArray new.
	aStream nextPut: 16r00; nextPut: 16r00; nextPut: 16r00; nextPut: 16r00.
	aStream nextPut: 16r00; nextPut: 16r40; nextPut: 16r50; nextPut: 16r40.
	aStream reset.
	
	reader := MysqlBinReader default.
	self assert: (reader doubleFrom: aStream) = 65.0.
	