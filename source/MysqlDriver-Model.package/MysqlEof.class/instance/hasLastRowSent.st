as yet unclassified
hasLastRowSent
	^ (serverStatus bitAnd: MysqlServerStatus statusLastRowSent) ~= 0
	