private
prepare: aString

	| preparedRequest statementId statement |
	preparedRequest := connection prepare: aString .
	preparedRequest isError ifTrue: 
			[ Dialect error signal: preparedRequest message ].
	statementId := preparedRequest prepareOkay stmtHandlerId .
	statement := MysqlDriverStmt onConnection: connection.
	^statement stmtId: statementId .