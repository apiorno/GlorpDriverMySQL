Testing
hasLastRowSent
	^ (serverStatus bitAnd: MysqlServerStatus statusLastRowSent) ~= 0
	