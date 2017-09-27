Tests
testNoInputParamExpectingResultSet
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#zero)
		do: [ :conn | 
			prep := conn
				prepare:
					'select * from testMisc 
				where name in (''key-0002'', ''key-0004'', ''key-0006'', ''key-0008'', ''key-0010'')
				order by name'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 5.
			self assert: (resp rows first atIndex: 1) equals: 'key-0002'.
			self assert: (resp rows last atIndex: 1) equals: 'key-0010'.
			self
				assert: (resp rows last atIndex: 3)
				equals: (Date fromString: 'Jul 01 2011') ]