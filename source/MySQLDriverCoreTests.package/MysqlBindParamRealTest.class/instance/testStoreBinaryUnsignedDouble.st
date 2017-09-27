Tests
testStoreBinaryUnsignedDouble
	theParam bindValue: 123456789123456789.123456789.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: (MysqlHelper bytesFromHexString: 'B4697B43F105CDBA'))]
		