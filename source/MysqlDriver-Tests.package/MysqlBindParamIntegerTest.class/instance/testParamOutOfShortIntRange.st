as yet unclassified
testParamOutOfShortIntRange
	theParam bindValue: -16r8001.
	self deny: (theParam paramType = MysqlTypes typeSHORT).
	theParam bindValue: -16r80.
	self deny: (theParam paramType = MysqlTypes typeSHORT).
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFF.
	self deny: (theParam paramType = MysqlTypes typeSHORT).
	theParam bindValue: 16r10000.
	self deny: (theParam paramType = MysqlTypes typeSHORT).
