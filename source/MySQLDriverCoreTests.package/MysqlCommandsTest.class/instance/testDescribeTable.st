Tests
testDescribeTable
	| results |
	results := self connection query: 'describe nameValue'.
	self assert: results rows size equals: 3.
