Tests
testReadTimeTypes
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#times)
		do: [ :conn | 
			prep := conn prepare: 'select * from testTimes order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 4.
			self
				assert: (resp rows first atIndex: 2)
				equals: (Date fromString: '07-01-2011').
			self
				assert: (resp rows first atIndex: 3)
				equals: (Time fromString: '18:35:23').
			self
				assert: (resp rows first atIndex: 4)
				equals:
					(DateAndTime
						localTimeZone: TimeZone default;
						fromString: '2011-07-02T10:12:45.000000000').
			self assert: (resp rows first atIndex: 5) equals: 1999.
			self
				assert: (resp rows second atIndex: 2)
				equals: (Date fromString: '06-01-2011').
			self
				assert: (resp rows second atIndex: 3)
				equals: (Duration fromString: '03:17:34:22').
			self
				assert: (resp rows second atIndex: 4)
				equals:
					(DateAndTime
						localTimeZone: TimeZone default;
						fromString: '2011-06-02T09:11:44.000000').
			self assert: (resp rows second atIndex: 5) equals: 2000 ]