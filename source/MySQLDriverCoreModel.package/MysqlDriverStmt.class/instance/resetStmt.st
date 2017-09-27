accessing
resetStmt
	| cmd |
	cmd := MysqlComResetStmt onSession: driver netSession.
	cmd statementId: stmtId.
	^ cmd execute.
	