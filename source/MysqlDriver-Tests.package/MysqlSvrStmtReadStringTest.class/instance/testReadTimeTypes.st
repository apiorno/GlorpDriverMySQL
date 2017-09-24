as yet unclassified
testReadTimeTypes
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

		self assert: (resp rows first atIndex: 2) = '2011-07-01'.
		self assert: (resp rows first atIndex: 3) = '18:35:23'.
		self assert: (resp rows first atIndex: 4) = '2011-07-02T10:12:45+00:00'.
		self assert: (resp rows first atIndex: 5) = '1980-01-12T00:45:56+00:00'.
		self assert: (resp rows first atIndex: 6) = '1999'.

		self assert: (resp rows second atIndex: 2) = '2011-06-01'.
		self assert: (resp rows second atIndex: 3) = '3:17:34:22'.
		self assert: (resp rows second atIndex: 4) = '2011-06-02T09:11:44+00:00'.
		self assert: (resp rows second atIndex: 5) = '1980-02-13T01:44:55+00:00']
		