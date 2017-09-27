Tests
testReadTimeTypes
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
			self assert: (resp rows first atIndex: 2) equals: '2011-07-01'.
			self assert: (resp rows first atIndex: 3) equals: '18:35:23'.
			self
				assert: (resp rows first atIndex: 4)
				equals: '2011-07-02 10:12'.
			self assert: (resp rows first atIndex: 5) equals: '1999'.
			self assert: (resp rows second atIndex: 2) equals: '2011-06-01'.
			self assert: (resp rows second atIndex: 3) equals: '3:17:34:22'.
			self
				assert: (resp rows second atIndex: 4)
				equals: '2011-06-02 09:11'.
			self assert: (resp rows second atIndex: 5) equals: '2000' ]