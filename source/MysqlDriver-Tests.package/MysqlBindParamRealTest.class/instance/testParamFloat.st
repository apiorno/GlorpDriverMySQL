as yet unclassified
testParamFloat
	theParam bindValue: 65.0.
	self assert: theParam paramType = MysqlTypes typeFLOAT.
	self assert: theParam isUnsigned.

	theParam bindValue: -65.0.
	self assert: theParam paramType = MysqlTypes typeFLOAT.
	self deny: theParam isUnsigned.
	