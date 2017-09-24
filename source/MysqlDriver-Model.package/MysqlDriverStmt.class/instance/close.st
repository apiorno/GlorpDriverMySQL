accessing
close
	| cmd |
	cmd := MysqlComCloseStmt onSession: driver netSession.
	cmd statementId: stmtId.
	^ cmd execute.
	