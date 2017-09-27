Tests
testParamSymbol
	theParam bindValue: #'Symbols are special'.
	self
		assert: theParam detectParamType
		equals: MysqlTypes typeVARSTRING.
	self assert: theParam isUnsigned