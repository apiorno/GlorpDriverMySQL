as yet unclassified
testStmtExecute
	| resp paramList prepResp conn stmt |
	conn := self connection.
	conn query: 'insert into mix values(''key01'', ''111222333444.555666777'')'.
	conn query: 'insert into mix values(''key02'', NULL)'.
	prepResp := conn prepare: 'select * from mix where name = ?'.
	stmt := MysqlDriverStmt onConnection: conn.
	paramList := Array with: (MysqlBindParam new bindValue: 'key01').
	stmt
		stmtId: prepResp prepareOkay stmtHandlerId;
		params: paramList.
	resp := stmt execute.
	self assert: resp isResultSet.
	self assert: resp rows size = 1.
	self assert: (resp rows first atIndex: 1) = 'key01'.
	self assert: (resp rows first atIndex: 2) = 111222333444.555666777s9.
	paramList :=  Array with: (MysqlBindParam new bindValue: 'key02').
	stmt params: paramList.
	resp := 	stmt execute.
	self assert: resp isResultSet.
	self assert: resp rows size = 1.
	self assert: (resp rows first atIndex: 1) = 'key02'.
	self assert: (resp rows first atIndex: 2) isNil
	