as yet unclassified
testParamText
	theParam bindValue: (Text fromString: 'Smalltalk is awesome').
	self assert: (theParam detectParamType = MysqlTypes typeVARSTRING).
	self assert: theParam isUnsigned.
	