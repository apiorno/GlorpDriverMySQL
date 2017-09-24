as yet unclassified
testInputParamExpectingResultSet
	| prep stmtId params resp stmt |
	self withFixtures: #(#zero) do: [:conn |
		prep := conn 
			prepare: 
				'select * from testMisc 
				where name in (?, ?, ?, ?, ?)'.
		stmtId := prep prepareOkay stmtHandlerId..
		params := Array new: (prep prepareOkay numParams).
		params
			at: 1 put: (MysqlBindParam withValue: 'key-0002');
			at: 2 put: (MysqlBindParam withValue: 'key-0004');
			at: 3 put: (MysqlBindParam withValue: 'key-0006');
			at: 4 put: (MysqlBindParam withValue: 'key-0008'); 
			at: 5 put: (MysqlBindParam withValue: 'key-0010'). 

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; params: params.

		resp := stmt execute.
		self assert: resp isResultSet.
		self assert: resp rows size = 5.
		self assert: (resp rows first atIndex: 1) = 'key-0002'.
		self assert: (resp rows last atIndex: 1) = 'key-0010'.
		self assert: (resp rows last atIndex: 3) = (Date fromString: 'Jul 01 2011')]  
	