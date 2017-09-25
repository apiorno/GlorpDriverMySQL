Tests
testReadLongInt
	| aStream reader |
	aStream := ReadWriteStream on: ByteArray new.
	aStream 
		nextPut: 16r41; 
		nextPut: 16r13;
		nextPut: 16r64;
		nextPut: 16rF0;
		nextPut: 16r41; 
		nextPut: 16r13;
		nextPut: 16r64;
		nextPut: 16rF0.
	aStream reset.

	reader := MysqlBinReader default.
	self assert: (reader bigIntFrom: aStream) = 17321991240700662593.
