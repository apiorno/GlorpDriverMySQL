Tests
testParamDateTime
	theParam bindValue: DateAndTime current.
	self assert: (theParam detectParamType = MysqlTypes typeDATETIME).
	self assert: theParam isUnsigned.
	