Tests
testStmtPrepare
	| resp conn |
	conn := self connection.
	resp := conn
		query: 'insert into nameValue values(''1'', ''key01'', ''value01'')'.
	self assert: resp isOkay.
	self assert: resp affectedRows equals: 1.
	resp := conn
		query:
			'insert into nameValue values
					(''2'', ''key02'', ''value02''), 
					(''3'', ''key03'', ''value03'')'.
	self assert: resp isOkay.
	self assert: resp affectedRows equals: 2.
	resp := conn prepare: 'select * from nameValue where name = ?'.
	self assert: resp isPrepareResponse.
	self assert: resp prepareOkay warningCount equals: 0.
	self assert: resp prepareOkay numParams equals: 1.
	self assert: resp paramDescriptors first name equals: '?'.
	self assert: resp prepareOkay numColumns equals: 3.
	self assert: resp columnDescriptors first name equals: 'id'.
	self assert: (resp columnDescriptors at: 2) name equals: 'name'.
	self assert: (resp columnDescriptors at: 3) name equals: 'value'