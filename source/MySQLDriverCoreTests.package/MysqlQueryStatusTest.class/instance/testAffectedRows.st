Tests
testAffectedRows
	| conn resp |
	conn := self connection.
	resp := conn
		query:
			'insert into nameValue values(''0'', ''statusKey01'', ''statusValue01'')'.
	self assert: resp isOkay.
	self assert: resp affectedRows equals: 1.
	resp := conn
		query:
			'insert into nameValue values(''0'', ''statusKey02'', ''statusValue03'')'.
	self assert: resp isOkay.
	self assert: resp affectedRows equals: 1.
	resp := conn
		query: 'delete from nameValue where id in (''1'', ''2'')'.
	self assert: resp isOkay.
	self assert: resp affectedRows equals: 2