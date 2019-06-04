"
- error
	syntax
	schema
- warning
	syntax
	truncation
	depracated(?)
- Genral
	DDL: create, alter, drop, truncate, comment, rename, ...
	DML: select, insert, update, delete, call, explain, lock, ...
	DCL: grant, revoke, ...
	TCL: begin, commit, savepoint, rollback, ...
- In and out of transaction state (server status flag)

"
Class {
	#name : #MysqlQueryStatusTest,
	#superclass : #MysqlTestCase,
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #Tests }
MysqlQueryStatusTest >> testAffectedRows [
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
]

{ #category : #Tests }
MysqlQueryStatusTest >> testAutoCommitMode [
	| conn resp |
	conn := self connection.
	resp := conn query: 'set autocommit = 0'.
	self
		assert: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit)
		equals: 0.
	resp := conn query: 'set autocommit = 1'.
	self
		deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0
]

{ #category : #Tests }
MysqlQueryStatusTest >> testInsertId [
	| conn resp |
	conn := self connection.
	resp := conn
		query:
			'insert into nameValue values(''0'', ''statusKey01'', ''statusValue02'')'.
	self assert: resp isOkay.
	self assert: resp insertId equals: 1.
	resp := conn
		query:
			'insert into nameValue values(''0'', ''statusKey02'', ''statusValue03'')'.
	self assert: resp isOkay.
	self assert: resp insertId equals: 2
]

{ #category : #Tests }
MysqlQueryStatusTest >> testServerStatus [
	| conn resp |
	conn := self connection.

	resp := conn query: 'insert into nameValue values(''0'', ''statusKey01'', ''statusValue01'')'.
	self assert: resp isOkay.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0.

	resp := conn query: 'insert into nameValue values(''0'', ''statusKey02'', ''statusValue02'')'.
	self assert: resp isOkay.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0.
	
	resp := conn query: 'select * from nameValue'.
	self assert: resp isResultSet.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusNoIndexUsed) = 0.
	self deny: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit) = 0.

]

{ #category : #Tests }
MysqlQueryStatusTest >> testTransactionModeCommit [
	| conn resp |
	conn := self connection.
	resp := conn query: 'start transaction'.
	self assert: resp isOkay.
	self
		assert: (resp serverStatus bitAnd: MysqlServerStatus statusInTransaction)
		equals: MysqlServerStatus statusInTransaction.
	resp := conn query: 'set autocommit = 0'.
	self assert: resp isOkay.
	self
		assert: (resp serverStatus bitAnd: MysqlServerStatus statusAutoCommit)
		equals: 0.
	resp := conn
		query:
			'insert into nameValue values(''0'', ''statusKey01'', ''statusValue02'')'.
	self assert: resp isOkay.
	resp := conn
		query:
			'insert into nameValue values(''0'', ''statusKey02'', ''statusValue03'')'.
	self assert: resp isOkay.
	resp := conn query: 'set autocommit = 1'.
	self assert: resp isOkay.
	resp := conn query: 'commit'.
	self assert: resp isOkay.
	resp := conn query: 'select count(*) from nameValue'.
	self assert: resp isResultSet.
	self assert: resp fields size equals: 1.
	self assert: resp rows size equals: 1.
	self assert: (resp rows first atIndex: 1) asInteger equals: 2
]

{ #category : #Tests }
MysqlQueryStatusTest >> testTransactionModeRollback [
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
]

{ #category : #Tests }
MysqlQueryStatusTest >> testTransactionStatus [
	| conn resp |
	conn := self connection.
	resp := conn query: 'start transaction'.
	self
		deny: (resp serverStatus bitAnd: MysqlServerStatus statusInTransaction) = 0.
	resp := conn query: 'rollback'.
	self
		assert: (resp serverStatus bitAnd: MysqlServerStatus statusInTransaction)
		equals: 0
]

{ #category : #Tests }
MysqlQueryStatusTest >> testWarnings [
	| conn resp |
	conn := self connection.

	"Change the sql_mode for the current session test (in case of strict mode enabled)"
	conn query: 'SET SESSION sql_mode = ''NO_ENGINE_SUBSTITUTION'';'.
	resp := conn
		query: 'insert into warn values(''1000'', ''value one'')'.
	self assert: resp isOkay.
	self assert: resp warningCount equals: 1.
	resp := conn
		query:
			'insert into warn values
				(''256'', ''value one two three four five six seven eight none ten'')'.
	self assert: resp isOkay.
	self assert: resp warningCount equals: 2
]
