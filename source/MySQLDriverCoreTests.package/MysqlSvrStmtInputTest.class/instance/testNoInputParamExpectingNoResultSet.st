Tests
testNoInputParamExpectingNoResultSet
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#zero)
		do: [ :conn | 
			prep := conn
				prepare:
					'delete from testMisc 
				where name in (''key-0006'', ''key-0007'',''key-0008'',''key-0009'')'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isOkay.
			self assert: resp affectedRows equals: 4 ]