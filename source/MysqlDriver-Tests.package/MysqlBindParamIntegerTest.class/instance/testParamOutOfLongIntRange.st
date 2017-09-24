as yet unclassified
testParamOutOfLongIntRange
	theParam bindValue: -16r80000001.
	self deny: (theParam paramType = MysqlTypes typeLONG).
	theParam bindValue: -16r8000.
	self deny: (theParam paramType = MysqlTypes typeLONG).
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFF.
	self deny: (theParam paramType = MysqlTypes typeLONG).
	theParam bindValue: 16r100000000.
	self deny: (theParam paramType = MysqlTypes typeLONG).
