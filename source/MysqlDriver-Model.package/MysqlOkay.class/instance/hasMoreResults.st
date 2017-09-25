Testing
hasMoreResults
	^ (serverStatus bitAnd: MysqlServerStatus moreResultsExist) ~= 0
	