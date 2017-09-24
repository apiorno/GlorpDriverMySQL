as yet unclassified
testStoreBinarySignedFraction
	theParam bindValue: -17/4.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: (MysqlHelper bytesFromHexString: '000011C0'))]
		