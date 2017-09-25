Tests
testStoreBinaryTinyInt
	theParam bindValue: -128.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r80)).
	theParam bindValue: -1.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16rFF)).

	theParam bindValue: 0.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r00)).
	theParam declaredUnsigned: true.
	theParam bindValue: 255.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16rFF)).
	