as yet unclassified
testInputTimeTypesNull
	| prep stmtId params stmt resp |
	self withFixtures: #(#times) do: [:conn |
		prep := conn prepare: 
			'update testTimes
			set dateValue = ?, timeValue = ?, dateTimeValue = ?, yearValue = ?
			where id = 1'.
		self assert: prep isOkay.
		
		stmtId := prep prepareOkay stmtHandlerId..
		params := Array new: (prep prepareOkay numParams).
		params 
			at: 1 put: (MysqlBindParam withValue: nil);
			at: 2 put: (MysqlBindParam withValue:  nil); 
			at: 3 put: (MysqlBindParam withValue: nil);
			at: 4 put: (MysqlBindParam withValue: nil).

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; params: params.
		resp := stmt execute.
		self assert: resp isOkay.
		self assert: resp affectedRows = 1.
		self assert: resp warningCount = 0].
		