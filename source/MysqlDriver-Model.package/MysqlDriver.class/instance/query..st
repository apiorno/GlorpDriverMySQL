accessing
query: queryString
	| qry results |

	self assertConnection.		
	qry := MysqlComQuery onSession: netSession.
	qry queryString: queryString.
	results := qry execute.
	
	^ results
