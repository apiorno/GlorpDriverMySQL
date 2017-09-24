as yet unclassified
testQueryWhithoutReturn
	| result |
	result := connection basicExecuteSQLString: '' .
	self assert: (result isEmpty)