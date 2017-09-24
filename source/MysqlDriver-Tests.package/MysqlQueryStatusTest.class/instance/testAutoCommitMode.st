as yet unclassified
testAutoCommitMode
	| conn resp |
	conn := self connection.
	resp := conn query: 'set autocommit = 0'.
	self assert: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0 .
	resp := conn query: 'set autocommit = 1'.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0.
