Testing
inTransaction
	| autoCommit inTx |
	autoCommit := (serverStatus bitAnd: MysqlServerStatus statusInTransaction) ~= 0.
	inTx := (serverStatus bitAnd: MysqlServerStatus statusInTransaction) ~= 0.
	^ autoCommit and: [inTx]
	