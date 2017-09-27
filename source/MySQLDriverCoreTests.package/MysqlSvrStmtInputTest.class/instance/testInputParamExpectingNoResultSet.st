Tests
testInputParamExpectingNoResultSet
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#zero)
		do: [ :conn | 
			prep := conn
				prepare:
					'delete from testMisc 
				where name in (?, ?, ?, ?)'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := Array new: prep prepareOkay numParams.
			params
				at: 1 put: (MysqlBindParam withValue: 'key-0006');
				at: 2 put: (MysqlBindParam withValue: 'key-0007');
				at: 3 put: (MysqlBindParam withValue: 'key-0008');
				at: 4 put: (MysqlBindParam withValue: 'key-0009').
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isOkay.
			self assert: resp affectedRows equals: 4 ]