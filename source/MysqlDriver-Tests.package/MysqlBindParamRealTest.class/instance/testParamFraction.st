Tests
testParamFraction
	theParam bindValue: 100/3.
	self assert: theParam paramType = MysqlTypes typeDOUBLE.
	self assert: theParam isUnsigned.

	theParam bindValue: -100/3.
	self assert: theParam paramType = MysqlTypes typeDOUBLE.
	self deny: theParam isUnsigned.
	
	theParam bindValue: 17/4.
	self assert: theParam paramType = MysqlTypes typeFLOAT.
	self assert: theParam isUnsigned.
	
	theParam bindValue: -17/4.
	self assert: theParam paramType = MysqlTypes typeFLOAT.
	self deny: theParam isUnsigned.
	