Tests
testParamDuration
	theParam bindValue: (Duration fromString: '10:02:30:45').
	self assert: (theParam detectParamType = MysqlTypes typeTIME).
	self assert: theParam isUnsigned.

	theParam bindValue: (Duration fromString: '-10:02:30:45').
	self assert: (theParam detectParamType = MysqlTypes typeTIME).
	self assert: theParam isUnsigned not.
	