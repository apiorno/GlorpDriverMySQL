Tests
testStoreBinaryBigInt
	theParam bindValue: -16r8000000000000000.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: '0000000000000080')).

	theParam bindValue: -16r80000001.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: 'FFFFFF7FFFFFFFFF')).

	theParam bindValue: 16r100000000.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: '0000000001000000')).

	self should: [theParam bindValue: 16rFFFFFFFFFFFFFFFF] raise: MysqlBindError.
	theParam declaredUnsigned: true.	
	theParam bindValue: 16rFFFFFFFFFFFFFFFF.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: 'FFFFFFFFFFFFFFFF')).
