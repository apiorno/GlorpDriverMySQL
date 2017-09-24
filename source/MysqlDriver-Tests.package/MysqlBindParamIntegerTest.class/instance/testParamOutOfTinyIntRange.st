as yet unclassified
testParamOutOfTinyIntRange
	theParam bindValue: -129.
	self deny: (theParam paramType = MysqlTypes typeTINY).
	theParam bindValue: 256.
	self deny: (theParam paramType = MysqlTypes typeTINY).
