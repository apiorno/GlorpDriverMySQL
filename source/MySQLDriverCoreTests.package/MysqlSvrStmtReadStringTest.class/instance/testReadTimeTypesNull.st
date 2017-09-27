Tests
testReadTimeTypesNull
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
			self deny: (resp rows third atIndex: 1) = 'NULL'.
			self assert: (resp rows third atIndex: 2) equals: 'NULL'.
			self assert: (resp rows third atIndex: 3) equals: 'NULL'.
			self assert: (resp rows third atIndex: 4) equals: 'NULL'.
			self assert: (resp rows third atIndex: 5) equals: 'NULL' ]