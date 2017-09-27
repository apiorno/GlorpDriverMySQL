Tests
testAutoCommitMode
	| conn resp |
	conn := self connection.
	resp := conn query: 'set autocommit = 0'.
	self
		assert: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit)
		equals: 0.
	resp := conn query: 'set autocommit = 1'.
	self
		deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0