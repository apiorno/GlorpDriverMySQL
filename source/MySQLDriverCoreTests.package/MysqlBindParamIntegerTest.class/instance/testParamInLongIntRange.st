Tests
testParamInLongIntRange
	theParam bindValue: -16r80000000.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self deny: theParam isUnsigned.
	theParam bindValue: -16r8001.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self deny: theParam isUnsigned.
	theParam bindValue: 16r10000.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self assert: theParam isUnsigned.
	theParam bindValue: 16rFFFFFFFF.
	self assert: theParam paramType equals: MysqlTypes typeLONGLONG.
	self assert: theParam isUnsigned.
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFFFFFF.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self assert: theParam isUnsigned