Tests
testParamTime
	theParam bindValue: Time now.
	self assert: theParam detectParamType equals: MysqlTypes typeTIME.
	self assert: theParam isUnsigned