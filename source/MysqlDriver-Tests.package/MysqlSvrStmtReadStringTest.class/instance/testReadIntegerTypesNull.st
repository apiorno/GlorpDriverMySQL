as yet unclassified
testReadIntegerTypesNull
	| prep stmtId params resp stmt |
	self withFixtures: #(#integers) do: [:conn |
		prep := conn prepare: 'select * from testIntegers order by id'.
		stmtId := prep prepareOkay stmtHandlerId..
		params := #().

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; params: params; typeMapResults: false.

		resp := stmt execute.
		self assert: resp isResultSet.
		self assert: resp rows size = 5.
		self assert: (resp rows third atIndex: 4) = 'NULL'.
		self assert: (resp rows third atIndex: 6) = '6000000002'.
		self assert: (resp rows fourth atIndex: 4) = '40003'.
		self assert: (resp rows fourth atIndex: 6) = 'NULL']
	