Tests
testReadIntegerTypes
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
			self assert: (resp rows first atIndex: 4) equals: '40000'.
			self assert: (resp rows first atIndex: 6) equals: '6000000000'.
			self assert: (resp rows second atIndex: 4) equals: '40001'.
			self assert: (resp rows second atIndex: 6) equals: '6000000001' ]