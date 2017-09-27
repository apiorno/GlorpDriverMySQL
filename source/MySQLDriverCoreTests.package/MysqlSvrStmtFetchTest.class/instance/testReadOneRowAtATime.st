Tests
testReadOneRowAtATime
	| rs rd |
	stmt params: (Array with: (MysqlBindParam withValue: '2011-09-01')).
	rs := stmt execute.
	self
		assert: rs isResultSet;
		assert: rs hasOpenCursor;
		deny: rs hasLastRowSent.
	10
		timesRepeat: [ rd := stmt fetchRows: 1.
			self
				assert: rd rows size equals: 1;
				deny: rd hasLastRowSent ].
	rd := stmt fetchRows: 1.
	self
		assert: rd rows isEmpty;
		assert: rd hasLastRowSent