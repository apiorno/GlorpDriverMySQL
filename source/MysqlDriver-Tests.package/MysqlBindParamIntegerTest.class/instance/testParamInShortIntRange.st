Tests
testParamInShortIntRange
	theParam bindValue: -16r8000.
	self assert: (theParam paramType = MysqlTypes typeSHORT).
	self deny: theParam isUnsigned.
	
	theParam bindValue: -16r81.
	self assert: (theParam paramType = MysqlTypes typeSHORT).
	self deny: theParam isUnsigned.

	theParam bindValue: 16r100.
	self assert: (theParam paramType = MysqlTypes typeSHORT).
	self assert: theParam isUnsigned.

	theParam bindValue: 16rFFFF.
	self assert: (theParam paramType = MysqlTypes typeLONG).
	self assert: theParam isUnsigned.

	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFF.
	self assert: (theParam paramType = MysqlTypes typeSHORT).
	self assert: theParam isUnsigned.
