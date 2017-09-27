Tests
testTransactionModeRollback
	| conn resp |
	conn := self connection.
	resp := conn query: 'start transaction'.
	self assert: resp isOkay.
	resp := conn
		query:
			'insert into nameValue values(''0'', ''statusKey01'', ''statusValue02'')'.
	self assert: resp isOkay.
	resp := conn
		query:
			'insert into nameValue values(''0'', ''statusKey02'', ''statusValue03'')'.
	self assert: resp isOkay.
	resp := conn query: 'rollback'.
	self assert: resp isOkay.
	self assert: resp warningCount equals: 0.
	resp := conn query: 'select count(*) from nameValue'.
	self assert: resp isResultSet.
	self assert: resp fields size equals: 1.
	self assert: resp rows size equals: 1.
	self assert: (resp rows first atIndex: 1) asInteger equals: 0