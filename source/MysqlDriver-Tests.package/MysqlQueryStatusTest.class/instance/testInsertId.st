as yet unclassified
testInsertId
	| conn resp |
	conn := self connection.

	resp := conn query: 'insert into nameValue values(''0'', ''statusKey01'', ''statusValue02'')'.
	self assert: resp isOkay.
	self assert: resp insertId = 1.

	resp := conn query: 'insert into nameValue values(''0'', ''statusKey02'', ''statusValue03'')'.
	self assert: resp isOkay.
	self assert: resp insertId = 2.
