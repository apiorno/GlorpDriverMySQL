Tests
testParamString
	theParam bindValue: 'Smalltalk is awesome'.
	self
		assert: theParam detectParamType
		equals: MysqlTypes typeVARSTRING.
	self assert: theParam isUnsigned