Tests
testStoreBinaryDuration
	theParam bindValue: (Duration zero).
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '00'.

	theParam bindValue: (Duration fromString: '10:02:30:45').
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '08000A000000021E2D'.

	theParam bindValue: (Duration fromString: '-10:02:30:45').
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '08010A000000021E2D'.

	theParam bindValue: (Duration fromString: '10:02:30:45.1234').
	self assert: 
		(MysqlHelper hexStringFromBytes: self storeBinary) = '0C000A000000021E2D08E20100'.
	