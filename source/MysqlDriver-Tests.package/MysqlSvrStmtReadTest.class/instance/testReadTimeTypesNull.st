as yet unclassified
testReadTimeTypesNull
	| prep stmtId params resp stmt |
	self 
		withFixtures: #(#times )
		do: 
			[ :conn | 
			prep := conn prepare: 'select * from testTimes order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size = 4.
			self assert: (resp rows third atIndex: 2) isNil.
			self assert: (resp rows third atIndex: 3) isNil.
			self assert: (resp rows third atIndex: 4) isNil.
			self assert: (resp rows third atIndex: 5) isNotNil ]