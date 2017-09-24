as yet unclassified
testReadSomeRowsAtATime
	| rs rd |
	stmt params: (Array with: (MysqlBindParam withValue: '2011-09-01')).
	rs := stmt execute.
	self assert: rs isResultSet; assert: rs hasOpenCursor; deny: rs hasLastRowSent.
	3 timesRepeat: [
		rd := stmt fetchRows: 3.
		self assert: rd rows size = 3; deny: rd hasLastRowSent].
	rd := stmt fetchRows: 3.
	self assert: rd rows size = 1; assert: rd hasLastRowSent.
		