Tests
testReadBlobTypes
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#blobs)
		do: [ :conn | 
			prep := conn
				prepare: 'select * from testBlobs where id < ? order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := Array with: (MysqlBindParam withValue: 5).
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 2.
			self
				assert: (resp rows first atIndex: 2)
				equals: '0123456789' asByteArray.
			self
				assert: (resp rows first atIndex: 3)
				equals: '0123456789' asByteArray.
			self
				assert: (resp rows first atIndex: 4)
				equals: '0123456789' asByteArray.
			self
				assert: (resp rows first atIndex: 5)
				equals: '0123456789' asByteArray.
			self
				assert: (resp rows second atIndex: 2)
				equals: '1234567890' asByteArray.
			self assert: (resp rows second atIndex: 3) isNil.
			self assert: (resp rows second atIndex: 4) isNil.
			self
				assert: (resp rows second atIndex: 5)
				equals: '1234567890' asByteArray ]