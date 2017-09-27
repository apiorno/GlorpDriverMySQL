accessing
fetchRows: num
	| cmd |
	cmd := MysqlComFetch onSession: driver netSession.
	cmd
		resultSetContext: rsContext;
		statementId: stmtId;
		numRows: num.		
	^ cmd execute
	 