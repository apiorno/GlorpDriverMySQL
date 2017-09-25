Tests
testParamDouble
	theParam bindValue: 123456789123456789.123456789.
	self assert: theParam paramType = MysqlTypes typeDOUBLE.
	self assert: theParam isUnsigned.
	
	theParam bindValue: -123456789123456789.123456789.
	self assert: theParam paramType = MysqlTypes typeDOUBLE.
	self deny: theParam isUnsigned.
