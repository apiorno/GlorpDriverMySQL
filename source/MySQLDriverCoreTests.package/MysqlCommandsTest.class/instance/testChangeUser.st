Tests
testChangeUser
	| spec altSpec conn |
	spec := self driverSpec.
	spec db: nil.
	altSpec := spec copy.
	altSpec user: self class resourceClass alternativeUsername.
	conn := self connection.
	
	self assert: (conn changeUser: altSpec) isOkay.
	self assert: (conn changeUser: spec) isOkay.
	self assert: (conn changeUser: altSpec) isOkay.
	self assert: (conn changeUser: spec) isOkay.
	conn disconnect.
	self should: [conn changeUser: spec] raise: MysqlNoConnectionError. 