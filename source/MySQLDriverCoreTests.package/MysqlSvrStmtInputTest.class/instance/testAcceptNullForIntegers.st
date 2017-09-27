Tests
testAcceptNullForIntegers
	| conn resp params stmtId stmt |
	conn := self connection.
	resp := conn
		prepare:
			'insert into testIntegers 
			(tinyintValue, smallintValue, mediumintValue, intValue, bigintValue)
		values (?, ?, ?, ?, ?)'.
	stmtId := resp prepareOkay stmtHandlerId.
	params := Array new: resp prepareOkay numParams.
	params
		at: 1 put: (MysqlBindParam withValue: nil);
		at: 2 put: (MysqlBindParam withValue: nil);
		at: 3 put: (MysqlBindParam withValue: nil);
		at: 4 put: (MysqlBindParam withValue: nil);
		at: 5 put: (MysqlBindParam withValue: 9999999999).
	stmt := MysqlDriverStmt onConnection: conn.
	stmt
		stmtId: stmtId;
		params: params.
	resp := stmt execute.
	self assert: resp isOkay.
	self assert: resp insertId equals: 1.
	self assert: resp warningCount equals: 0.
	resp := conn prepare: 'select * from testIntegers limit 1'.
	stmtId := resp prepareOkay stmtHandlerId.
	params := #().
	stmt := MysqlDriverStmt onConnection: conn.
	stmt
		stmtId: stmtId;
		params: params.
	resp := stmt execute.
	self assert: resp isResultSet.
	self assert: resp rows size equals: 1.
	self assert: (resp rows first atIndex: 1) equals: 1.
	self assert: (resp rows first atIndex: 2) isNil.
	self assert: (resp rows first atIndex: 3) isNil.
	self assert: (resp rows first atIndex: 4) isNil.
	self assert: (resp rows first atIndex: 5) isNil.
	self assert: (resp rows first atIndex: 6) equals: 9999999999