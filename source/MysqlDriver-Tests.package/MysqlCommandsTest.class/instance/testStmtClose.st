as yet unclassified
testStmtClose
	| resp paramList prepResp conn stmt |

	conn := self connection.
	conn query: 'insert into mix values(''key01'', ''111222333444.555666777'')'.
	conn query: 'insert into mix values(''key02'', NULL)'.
	prepResp := conn prepare: 'select * from mix where name = ?'.

	stmt := MysqlDriverStmt onConnection: conn.
	paramList := Array with: (MysqlBindParam new bindValue: 'key01').
	stmt stmtId: prepResp prepareOkay stmtHandlerId; params: paramList.
	
	stmt close. "will try to use after close"
	resp := stmt execute.		
	self assert: resp isError.
	self assert: (resp sqlState = 'HY000').
	self assert: (resp errNo = 1243).
	