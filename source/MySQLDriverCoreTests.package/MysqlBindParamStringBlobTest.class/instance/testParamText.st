Tests
testParamText
	theParam bindValue: (Text fromString: 'Smalltalk is awesome').
	self
		assert: theParam detectParamType
		equals: MysqlTypes typeVARSTRING.
	self assert: theParam isUnsigned