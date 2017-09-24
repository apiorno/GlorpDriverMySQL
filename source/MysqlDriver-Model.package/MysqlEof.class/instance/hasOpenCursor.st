as yet unclassified
hasOpenCursor
	^ (serverStatus bitAnd: MysqlServerStatus statusCursorExists) ~= 0
	