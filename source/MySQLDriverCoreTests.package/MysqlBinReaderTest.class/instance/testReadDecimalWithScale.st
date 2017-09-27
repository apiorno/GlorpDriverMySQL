Tests
testReadDecimalWithScale
	| aStream reader |
	aStream := ReadWriteStream on: ByteArray new.
	MysqlHelper encodeLcs: '12345.6789' asByteArray on: aStream.
	aStream reset.
	reader := MysqlBinReader default.
	self
		assert: (reader decimalWithScale: 4 from: aStream)
		equals: '12345.6789s4' asNumber