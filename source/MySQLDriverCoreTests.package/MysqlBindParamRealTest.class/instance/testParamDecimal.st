Tests
testParamDecimal
	theParam bindValue: 12345.678901s6.
	self assert: theParam paramType equals: MysqlTypes typeDECIMAL.
	self assert: theParam isUnsigned.
	theParam bindValue: -12345.678901s6.
	self assert: theParam paramType equals: MysqlTypes typeDECIMAL.
	self deny: theParam isUnsigned