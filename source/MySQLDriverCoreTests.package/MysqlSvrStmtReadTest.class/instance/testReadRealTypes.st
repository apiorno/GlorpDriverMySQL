Tests
testReadRealTypes
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#reals)
		do: [ :conn | 
			prep := conn prepare: 'select * from testReals order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 3.
			self assert: ((resp rows first atIndex: 2) closeTo: 1.1).
			self assert: ((resp rows first atIndex: 3) closeTo: 11.11).
			self assert: ((resp rows first atIndex: 4) closeTo: 222.222).
			self
				assert: (resp rows first atIndex: 5)
				equals: (3333333333 / 1000000 asScaledDecimal: 6).
			self
				assert: (resp rows first atIndex: 6)
				equals: (4444444444 / 1000000 asScaledDecimal: 6) ]