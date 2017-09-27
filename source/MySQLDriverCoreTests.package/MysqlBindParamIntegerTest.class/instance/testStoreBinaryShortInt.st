Tests
testStoreBinaryShortInt
	theParam bindValue: -16r8000.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r00 with: 16r80)).
	theParam bindValue: -16r81.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r7F with: 16rFF)).

	theParam bindValue: 16r100.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r00 with: 16r01)).
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFF.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16rFF with: 16rFF)).
	