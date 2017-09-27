Tests
testParamFloat
	theParam bindValue: 65.0.
	self assert: theParam paramType equals: MysqlTypes typeFLOAT.
	self assert: theParam isUnsigned.
	theParam bindValue: -65.0.
	self assert: theParam paramType equals: MysqlTypes typeFLOAT.
	self deny: theParam isUnsigned