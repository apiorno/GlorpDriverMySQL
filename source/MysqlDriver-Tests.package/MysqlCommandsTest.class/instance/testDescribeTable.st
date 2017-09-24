as yet unclassified
testDescribeTable
	| results |
	results := self connection query: 'describe nameValue'.
	self assert: (results rows size = 3).
