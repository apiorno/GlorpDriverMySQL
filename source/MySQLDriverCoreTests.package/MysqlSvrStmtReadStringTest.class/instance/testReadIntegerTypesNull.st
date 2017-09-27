Tests
testReadIntegerTypesNull
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#integers)
		do: [ :conn | 
			prep := conn prepare: 'select * from testIntegers order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 5.
			self assert: (resp rows third atIndex: 4) equals: 'NULL'.
			self assert: (resp rows third atIndex: 6) equals: '6000000002'.
			self assert: (resp rows fourth atIndex: 4) equals: '40003'.
			self assert: (resp rows fourth atIndex: 6) equals: 'NULL' ]