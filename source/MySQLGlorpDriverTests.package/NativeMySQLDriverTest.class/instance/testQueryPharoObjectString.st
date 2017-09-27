Tests
testQueryPharoObjectString
	| result |
	result := connection basicExecuteSQLString: 'select UPPER("yolo")' .
	self assert: (result next includes: 'YOLO')