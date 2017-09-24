as yet unclassified
testParamBoolean
	theParam bindValue: true.
	self assert: (theParam detectParamType = MysqlTypes typeTINY).
	self assert: theParam isUnsigned.

	theParam bindValue: false.
	self assert: (theParam detectParamType = MysqlTypes typeTINY).
	self assert: theParam isUnsigned.
