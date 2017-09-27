Tests
testReadTimeTypesNeg
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#times)
		do: [ :conn | 
			prep := conn prepare: 'select * from testTimes order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 4.
			self assert: (resp rows fourth atIndex: 3) equals: '-0:16:33:21' ]