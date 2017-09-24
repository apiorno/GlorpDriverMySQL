as yet unclassified
testQueryPharoObjectInteger
	| result |
	result := connection basicExecuteSQLString: 'select 1' .
	self assert: (result next includes: 1)