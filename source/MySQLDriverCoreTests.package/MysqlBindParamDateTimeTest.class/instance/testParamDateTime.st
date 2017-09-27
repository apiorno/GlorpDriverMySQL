Tests
testParamDateTime
	theParam bindValue: DateAndTime current.
	self assert: theParam detectParamType equals: MysqlTypes typeDATETIME.
	self assert: theParam isUnsigned