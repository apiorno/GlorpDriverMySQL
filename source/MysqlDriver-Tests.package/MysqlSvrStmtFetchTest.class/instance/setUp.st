as yet unclassified
setUp
	|  stmtId resp |
	super setUp.
	
	self withFixtures: #(#zero) do: [:conn | 
		resp := conn prepare: 
			'select name, value, entryOn, notes from testMisc 
			where entryOn < ?'.
		stmtId := resp prepareOkay stmtHandlerId.

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; cursoredFetch: true]
	