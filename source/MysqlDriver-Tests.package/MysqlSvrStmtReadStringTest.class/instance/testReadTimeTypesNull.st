as yet unclassified
testReadTimeTypesNull
	| prep stmtId params resp stmt |
	self withFixtures: #(#times) do: [:conn |
		prep := conn prepare: 'select * from testTimes order by id'.
		stmtId := prep prepareOkay stmtHandlerId..
		params := #().

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; params: params; typeMapResults: false.

		resp := stmt execute.
		self assert: resp isResultSet.
		self assert: resp rows size = 4.

		self assert: (resp rows third atIndex: 2) = 'NULL'.
		self assert: (resp rows third atIndex: 3) = 'NULL'.
		self assert: (resp rows third atIndex: 4) = 'NULL'.
		self deny: (resp rows third atIndex: 5) = 'NULL'.
		]