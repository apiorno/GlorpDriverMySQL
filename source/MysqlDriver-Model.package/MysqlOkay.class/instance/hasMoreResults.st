as yet unclassified
hasMoreResults
	^ (serverStatus bitAnd: MysqlServerStatus moreResultsExist) ~= 0
	