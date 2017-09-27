Tests
testInputTimeTypesNeg
	| prep stmtId params stmt resp |
	self
		withFixtures: #(#times)
		do: [ :conn | 
			prep := conn
				prepare:
					'update testTimes
			set dateValue = ?, timeValue = ?, dateTimeValue = ?,
				timeStampValue = ?, yearValue = ?
			where id = 1'.
			self assert: prep isOkay.
			stmtId := prep prepareOkay stmtHandlerId.
			params := Array new: prep prepareOkay numParams.
			params
				at: 1 put: (MysqlBindParam withValue: '2011-11-15');
				at: 2 put: (MysqlBindParam withValue: '-10 16:33:21');
				"same as -256:33;21"
					at: 3 put: (MysqlBindParam withValue: '2010-10-31 22:11:33');
				at: 4 put: (MysqlBindParam withValue: '2017-09-26 20:52:00');
				at: 5 put: (MysqlBindParam withValue: 2020).
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params.
			resp := stmt execute.
			self assert: resp isOkay.
			self assert: resp affectedRows equals: 1.
			self assert: resp warningCount equals: 0 ]