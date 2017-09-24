as yet unclassified
testParamInBigIntRange
	theParam bindValue: -16r8000000000000000.
	self assert: (theParam paramType = MysqlTypes typeLONGLONG).
	self deny: theParam isUnsigned.
	
	theParam bindValue: -16r80000001.
	self assert: (theParam paramType = MysqlTypes typeLONGLONG).
	self deny: theParam isUnsigned.

	theParam bindValue: 16r100000000.
	self assert: (theParam paramType = MysqlTypes typeLONGLONG).
	self assert: theParam isUnsigned.

	self should: [theParam bindValue: 16rFFFFFFFFFFFFFFFF]  raise: MysqlBindError.
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFFFFFFFFFFFFFF.
	self assert: (theParam paramType = MysqlTypes typeLONGLONG).
	self assert: theParam isUnsigned.
