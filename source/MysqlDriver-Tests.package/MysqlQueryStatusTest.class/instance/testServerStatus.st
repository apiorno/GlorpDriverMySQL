as yet unclassified
testServerStatus
	| conn resp |
	conn := self connection.

	resp := conn query: 'insert into nameValue values(''0'', ''statusKey01'', ''statusValue01'')'.
	self assert: resp isOkay.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0.

	resp := conn query: 'insert into nameValue values(''0'', ''statusKey02'', ''statusValue02'')'.
	self assert: resp isOkay.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0.
	
	resp := conn query: 'select * from nameValue'.
	self assert: resp isResultSet.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusNoIndexUsed) = 0.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0.
