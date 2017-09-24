as yet unclassified
testStmtPrepare
	| resp conn |
	conn := self connection.
	resp := conn query: 'insert into nameValue values(''1'', ''key01'', ''value01'')'.
	self assert: resp isOkay.
	self assert: resp affectedRows = 1.
	resp := conn query: 'insert into nameValue values
					(''2'', ''key02'', ''value02''), 
					(''3'', ''key03'', ''value03'')'.
	self assert: resp isOkay.
	self assert: resp affectedRows = 2.
	resp := conn prepare: 'select * from nameValue where name = ?'.
	self assert: resp isPrepareResponse.
	self assert: resp prepareOkay warningCount = 0.
	self assert: resp prepareOkay numParams = 1.
	self assert: (resp paramDescriptors first) name = '?'.
	self assert: resp prepareOkay numColumns = 3.
	self assert: (resp columnDescriptors first) name = 'id'.
	self assert: (resp columnDescriptors at: 2) name = 'name'.
	self assert: (resp columnDescriptors at: 3) name = 'value'