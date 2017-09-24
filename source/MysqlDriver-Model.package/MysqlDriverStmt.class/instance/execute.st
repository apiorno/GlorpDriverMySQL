accessing
execute
	| cmd resp |
	resp := self resetStmt.
	resp isError ifTrue: [ ^ resp ].
	self sendLongData.
	cmd := MysqlComExecute onSession: driver netSession.
	cmd
		cursoredFetch: cursoredFetch;
		mapResultsToNativeTypes: typeMapResults;
		statementId: stmtId;
		params: params asArray.
	resp := cmd execute.
	resp isError ifTrue: [ self error: resp message ].
	
	
	rsContext := resp isResultSet 
		ifTrue: [ 
			resp statement: self.
			resp ]
		ifFalse: [ nil ].
	^ resp