as yet unclassified
testAcceptNullForIntegers
	| conn resp params stmtId stmt |
	conn := self connection.
	
	"Change the sql_mode for the current session test (in case of strict mode enabled)"
	conn query: 'SET SESSION sql_mode = ''NO_ENGINE_SUBSTITUTION'';'.
	
	resp := conn prepare: 'insert into testIntegers 
			(tinyintValue, smallintValue, mediumintValue, intValue, bigintValue)
		values (?, ?, ?, ?, ?)'.
	stmtId := resp prepareOkay stmtHandlerId.
	params := Array new: resp prepareOkay numParams.
	params
		at: 1 put: (MysqlBindParam withValue: 'NULL');
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
	self assert: resp insertId = 1.
	self assert: resp warningCount = 1. "String 'NULL' to int conversion"
	resp := conn prepare: 'select * from testIntegers limit 1'.
	stmtId := resp prepareOkay stmtHandlerId.
	params := #().
	stmt := MysqlDriverStmt onConnection: conn.
	stmt
		stmtId: stmtId;
		params: params.
	resp := stmt execute.
	self assert: resp isResultSet.
	self assert: resp rows size = 1.
	self assert: (resp rows first atIndex: 1) = 1.
	self assert: (resp rows first atIndex: 2) = 0. "The string 'NULL' got conerted to 0"
	self assert: (resp rows first atIndex: 3) isNil.
	self assert: (resp rows first atIndex: 4) isNil.
	self assert: (resp rows first atIndex: 5) isNil.
	self assert: (resp rows first atIndex: 6) = 9999999999