as yet unclassified
testParamCharacter
	theParam bindValue: $A.
	self assert: (theParam detectParamType = MysqlTypes typeSTRING).
	self assert: theParam isUnsigned.
