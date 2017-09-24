as yet unclassified
testParamDate
	theParam bindValue: (Date fromString: '06-21-2011').
	self assert: (theParam detectParamType = MysqlTypes typeDATE).
	self assert: theParam isUnsigned.
	
	