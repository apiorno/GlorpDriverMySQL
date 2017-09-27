Testing
hasOpenCursor
	^ (serverStatus bitAnd: MysqlServerStatus statusCursorExists) ~= 0
	