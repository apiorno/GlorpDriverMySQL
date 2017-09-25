Tests
testStoreBinaryLongInt
	theParam bindValue: -16r80000000.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: '00000080')).

	theParam bindValue: -16r8001.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: 'FF7FFFFF')).

	theParam bindValue: 16r10000.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: '00000100')).

	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFFFFFF.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: 'FFFFFFFF')).
	