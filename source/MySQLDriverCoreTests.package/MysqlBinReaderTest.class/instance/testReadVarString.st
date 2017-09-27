Tests
testReadVarString
	| aStream reader longString |
	aStream := ReadWriteStream on: ByteArray new.
	longString := '12345678901234567890123456789012345678901234567890'
		, '12345678901234567890123456789012345678901234567890'
		, '12345678901234567890123456789012345678901234567890'
		, '12345678901234567890123456789012345678901234567890'
		, '12345678901234567890123456789012345678901234567890'
		, '12345678901234567890123456789012345678901234567890'.
	MysqlHelper
		encodeLcs: (longString first: 9) asByteArray on: aStream;
		encodeLcs: longString asByteArray on: aStream.
	aStream reset.
	reader := MysqlBinReader default.
	self assert: (reader varStringFrom: aStream) equals: '123456789'.
	self assert: (reader varStringFrom: aStream) equals: longString