Tests
testParamCharacter
	theParam bindValue: $A.
	self assert: theParam detectParamType equals: MysqlTypes typeSTRING.
	self assert: theParam isUnsigned