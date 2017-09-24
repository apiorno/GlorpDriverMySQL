as yet unclassified
testParamSymbol
	theParam bindValue: #'Symbols are special'.
	self assert: (theParam detectParamType = MysqlTypes typeVARSTRING).
	self assert: theParam isUnsigned.
	