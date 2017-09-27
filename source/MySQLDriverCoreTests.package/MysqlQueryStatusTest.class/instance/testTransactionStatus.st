Tests
testTransactionStatus
	| conn resp |
	conn := self connection.
	resp := conn query: 'start transaction'.
	self
		deny: (resp serverStatus bitAnd: MysqlServerStatus statusInTransaction) = 0.
	resp := conn query: 'rollback'.
	self
		assert: (resp serverStatus bitAnd: MysqlServerStatus statusInTransaction)
		equals: 0