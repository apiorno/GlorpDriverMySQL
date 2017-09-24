as yet unclassified
testAcceptPositiveIntegers
	| prep stmtId params resp stmt |
	self withFixtures: #(#integers) do: [:conn |
		prep := conn prepare: 
			'select * from testIntegers 
			where 
				tinyintValue = ? and smallintValue = ? and
				mediumintValue = ? and intValue = 100001 and
				bigintValue = 6000000001 
			order by id'.
		stmtId := prep prepareOkay stmtHandlerId.
	
		params := MysqlBindParam 
					listOfSize: prep prepareOkay numParams 
					forDescriptors: prep paramDescriptors.
		params first bindValue: 1.
		(params at: 2) bindValue: 301.
		(params at: 3) bindValue: 40001.

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; params: params.

		resp := stmt execute.		
		self assert: resp isResultSet.
		self assert: resp rows size = 1.
		self assert: (resp rows first atIndex: 2) = 1.
		self assert: (resp rows first atIndex: 3) = 301.
		self assert: (resp rows first atIndex: 4) = 40001.
		self assert: (resp rows first atIndex: 5) = 100001.
		self assert: (resp rows first atIndex: 6) = 6000000001]
	