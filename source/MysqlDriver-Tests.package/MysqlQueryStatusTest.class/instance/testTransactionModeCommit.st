as yet unclassified
testTransactionModeCommit
	| conn resp |
	conn := self connection.
	resp := conn query: 'start transaction'.
	self assert: resp isOkay.
	self assert: (resp serverStatus bitAnd: MysqlServerStatus statusInTransaction) 
				= MysqlServerStatus statusInTransaction.
	resp := conn query: 'set autocommit = 0'.
	self assert: resp isOkay.
	self assert: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0.

	resp := conn query: 'insert into nameValue values(''0'', ''statusKey01'', ''statusValue02'')'.
	self assert: resp isOkay.
	resp := conn query: 'insert into nameValue values(''0'', ''statusKey02'', ''statusValue03'')'.
	self assert: resp isOkay.

    resp := conn query: 'set autocommit = 1'.
    self assert: resp isOkay.

    resp := conn query: 'commit'.
    self assert: resp isOkay.

	resp := conn query: 'select count(*) from nameValue'.
	self assert: resp isResultSet.
	self assert: resp fields size = 1.
	self assert: resp rows size = 1.
	self assert: (resp rows first atIndex: 1) asInteger = 2.
