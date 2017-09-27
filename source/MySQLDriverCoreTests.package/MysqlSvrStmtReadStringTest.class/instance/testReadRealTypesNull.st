Tests
testReadRealTypesNull
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
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 3.
			self assert: (resp rows second atIndex: 2) equals: 'NULL'.
			self assert: (resp rows second atIndex: 3) equals: 'NULL'.
			self assert: (resp rows second atIndex: 4) equals: 'NULL'.
			self assert: (resp rows second atIndex: 5) equals: 'NULL'.
			self
				assert: (resp rows second atIndex: 6)
				equals: (-5555555555 / 1000000 asScaledDecimal: 6) asString ]