Class {
	#name : #MysqlCommandsTest,
	#superclass : #MysqlTestCase,
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #Tests }
MysqlCommandsTest >> testChangeUser [
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
]

{ #category : #Tests }
MysqlCommandsTest >> testDescribeTable [
	| results |
	results := self connection query: 'describe nameValue'.
	self assert: results rows size equals: 3.

]

{ #category : #Tests }
MysqlCommandsTest >> testPing [
	| conn |
	conn := self connection.
	self assert: conn ping isOkay.
	conn disconnect.
	self should: [conn ping] raise: MysqlNoConnectionError 
]

{ #category : #Tests }
MysqlCommandsTest >> testStmtClose [
	| resp paramList prepResp conn stmt |

	conn := self connection.
	conn query: 'insert into mix values(''key01'', ''111222333444.555666777'')'.
	conn query: 'insert into mix values(''key02'', NULL)'.
	prepResp := conn prepare: 'select * from mix where name = ?'.

	stmt := MysqlDriverStmt onConnection: conn.
	paramList := Array with: (MysqlBindParam new bindValue: 'key01').
	stmt stmtId: prepResp prepareOkay stmtHandlerId; params: paramList.
	
	stmt close. "will try to use after close"
	resp := stmt execute.		
	self assert: resp isError.
	self assert: resp sqlState equals: 'HY000'.
	self assert: resp errNo equals: 1243.
	
]

{ #category : #Tests }
MysqlCommandsTest >> testStmtExecute [
	| resp paramList prepResp conn stmt |
	conn := self connection.
	conn
		query: 'insert into mix values(''key01'', ''111222333444.555666777'')'.
	conn query: 'insert into mix values(''key02'', NULL)'.
	prepResp := conn prepare: 'select * from mix where name = ?'.
	stmt := MysqlDriverStmt onConnection: conn.
	paramList := Array with: (MysqlBindParam new bindValue: 'key01').
	stmt
		stmtId: prepResp prepareOkay stmtHandlerId;
		params: paramList.
	resp := stmt execute.
	self assert: resp isResultSet.
	self assert: resp rows size equals: 1.
	self assert: (resp rows first atIndex: 1) equals: 'key01'.
	self
		assert: (resp rows first atIndex: 2)
		equals: 111222333444.555666777s9.
	paramList := Array with: (MysqlBindParam new bindValue: 'key02').
	stmt params: paramList.
	resp := stmt execute.
	self assert: resp isResultSet.
	self assert: resp rows size equals: 1.
	self assert: (resp rows first atIndex: 1) equals: 'key02'.
	self assert: (resp rows first atIndex: 2) isNil
]

{ #category : #Tests }
MysqlCommandsTest >> testStmtPrepare [
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
]
