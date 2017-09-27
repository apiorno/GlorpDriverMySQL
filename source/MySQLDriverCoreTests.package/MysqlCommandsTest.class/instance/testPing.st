Tests
testPing
	| conn |
	conn := self connection.
	self assert: conn ping isOkay.
	conn disconnect.
	self should: [conn ping] raise: MysqlNoConnectionError 