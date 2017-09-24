as yet unclassified
testReadRealTypesNull
	| prep stmtId params resp stmt |
	self 
		withFixtures: #(#reals )
		do: 
			[ :conn | 
			prep := conn prepare: 'select * from testReals order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size = 3.
			self assert: (resp rows second atIndex: 2) isNil.
			self assert: (resp rows second atIndex: 3) isNil.
			self assert: (resp rows second atIndex: 4) isNil.
			self assert: (resp rows second atIndex: 5) isNil.
			self assert: (resp rows second atIndex: 6) = (-5555555555 / 1000000 asScaledDecimal: 6) ]