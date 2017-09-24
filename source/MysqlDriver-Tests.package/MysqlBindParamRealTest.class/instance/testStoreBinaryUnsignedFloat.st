as yet unclassified
testStoreBinaryUnsignedFloat
	theParam bindValue: 65.0.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: (MysqlHelper bytesFromHexString: '00405040'))]
		