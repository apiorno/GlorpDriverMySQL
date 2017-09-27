Accessing
prepare: queryString
	| prepStmt prepResp |

	self assertConnection.		
	prepStmt := MysqlComPrepare onSession: netSession.
	prepStmt queryString: queryString.
	prepResp := prepStmt execute. "error or prepare reponse"
	
	^ prepResp
