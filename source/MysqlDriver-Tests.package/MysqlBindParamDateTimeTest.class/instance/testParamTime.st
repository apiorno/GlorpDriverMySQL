as yet unclassified
testParamTime
	theParam bindValue: Time now.
	self assert: (theParam detectParamType = MysqlTypes typeTIME).
	self assert: theParam isUnsigned.
	