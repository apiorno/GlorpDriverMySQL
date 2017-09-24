as yet unclassified
testReadCharTypes
	| prep stmtId params resp stmt |
	self withFixtures: #(#chars) do: [:conn |
		prep := conn prepare: 'select * from testChars where id < ? order by id'.
		stmtId := prep prepareOkay stmtHandlerId..
		params := Array with: (MysqlBindParam withValue: 5).

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; params: params.

		resp := stmt execute.                                                                                           	self assert: resp isResultSet.
		self assert: resp rows size = 2.
		
		self assert: (resp rows first atIndex: 2) = 'smalltalk'.
		self assert: (resp rows first atIndex: 3) = 'An awesome programming environment'.
		
		self assert: (resp rows second atIndex: 2) = 'lisp'.
		self assert: (resp rows second atIndex: 3) = 'So is this one' ]
	