as yet unclassified
testReadAllRowsAtATime
	| rs rd |
	stmt params: (Array with: (MysqlBindParam withValue: '2011-09-01')) .
	rs := stmt execute.
	self assert: rs isResultSet; assert: rs hasOpenCursor; deny: rs hasLastRowSent.
	rd := stmt fetchRows: 1000.
	self assert: rd rows size = 10; assert: rs hasOpenCursor; assert: rd hasLastRowSent.
	rd := stmt fetchRows: 1.
	self assert: rd isError
	