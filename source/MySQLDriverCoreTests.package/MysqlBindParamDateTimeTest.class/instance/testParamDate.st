Tests
testParamDate
	theParam bindValue: (Date fromString: '06-21-2011').
	self assert: theParam detectParamType equals: MysqlTypes typeDATE.
	self assert: theParam isUnsigned