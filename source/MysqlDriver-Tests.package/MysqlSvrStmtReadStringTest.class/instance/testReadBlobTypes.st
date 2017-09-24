as yet unclassified
testReadBlobTypes
	| prep stmtId params resp stmt |
	self withFixtures: #(#blobs) do: [:conn |
		prep := conn prepare: 'select * from testBlobs where id < ? order by id'.
		stmtId := prep prepareOkay stmtHandlerId..
		params := Array with: (MysqlBindParam withValue: 5).

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; params: params; typeMapResults: false.

		resp := stmt execute.
		self assert: resp isResultSet.
		self assert: resp rows size = 2.
		self assert: (resp rows first atIndex: 2) = '0123456789'.
		self assert: (resp rows first atIndex: 3) = '0123456789'.
		self assert: (resp rows first atIndex: 4) = '0123456789'.
		self assert: (resp rows first atIndex: 5) = '0123456789'.
		
		self assert: (resp rows second atIndex: 2) = '1234567890'.
		self assert: (resp rows second atIndex: 3) = 'NULL'.
		self assert: (resp rows second atIndex: 4) = 'NULL'.
		self assert: (resp rows second atIndex: 5) = '1234567890']
	