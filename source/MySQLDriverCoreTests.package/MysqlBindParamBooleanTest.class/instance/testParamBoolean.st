Tests
testParamBoolean
	theParam bindValue: true.
	self assert: theParam detectParamType equals: MysqlTypes typeTINY.
	self assert: theParam isUnsigned.
	theParam bindValue: false.
	self assert: theParam detectParamType equals: MysqlTypes typeTINY.
	self assert: theParam isUnsigned