Tests
testParamStoreBinaryBoolean
	theParam bindValue: true.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r01)).

	theParam bindValue: false.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r00)).
