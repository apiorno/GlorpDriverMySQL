Tests
testReadVarBlob
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
	self
		assert: (reader varBlobFrom: aStream)
		equals: '123456789' asByteArray.
	self
		assert: (reader varBlobFrom: aStream)
		equals: longString asByteArray