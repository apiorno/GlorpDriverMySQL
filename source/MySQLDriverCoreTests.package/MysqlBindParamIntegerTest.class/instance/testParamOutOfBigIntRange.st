Tests
testParamOutOfBigIntRange
	self should: [theParam bindValue: -16r8000000000000001] raise: MysqlBindError.
	theParam bindValue: -16r80000000.
	self deny: (theParam paramType = MysqlTypes typeLONGLONG).
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFFFFFF.
	self deny: (theParam paramType = MysqlTypes typeLONGLONG).
	self should: [theParam bindValue: 16r10000000000000000] raise: MysqlBindError.
