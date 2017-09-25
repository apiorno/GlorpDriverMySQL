Tests
testParamString
	theParam bindValue: 'Smalltalk is awesome'.
	self assert: (theParam detectParamType = MysqlTypes typeVARSTRING).
	self assert: theParam isUnsigned.
	