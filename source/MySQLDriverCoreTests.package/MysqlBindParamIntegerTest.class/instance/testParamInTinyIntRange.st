Tests
testParamInTinyIntRange
	theParam bindValue: -128.
	self assert: theParam paramType equals: MysqlTypes typeTINY.
	theParam bindValue: 0.
	self assert: theParam paramType equals: MysqlTypes typeTINY.
	theParam bindValue: 255.
	self assert: theParam paramType equals: MysqlTypes typeSHORT