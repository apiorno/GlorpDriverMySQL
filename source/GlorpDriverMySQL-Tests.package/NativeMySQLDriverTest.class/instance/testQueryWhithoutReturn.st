Tests
testQueryWhithoutReturn
	| result |
	result := connection basicExecuteSQLString: '' .
	self assert: (result isEmpty)