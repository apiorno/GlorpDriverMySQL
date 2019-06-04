Class {
	#name : #MysqlSvrStmtFetchTest,
	#superclass : #MysqlTestCase,
	#instVars : [
		'stmt'
	],
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #'Test Support' }
MysqlSvrStmtFetchTest >> scenarios [
^ '
- should read zero rows
- should read one row
- should read some rows
- should read all rows in batches 
'

]

{ #category : #Initialization }
MysqlSvrStmtFetchTest >> setUp [
	|  stmtId resp |
	super setUp.
	
	self withFixtures: #(#zero) do: [:conn | 
		resp := conn prepare: 
			'select name, value, entryOn, notes from testMisc 
			where entryOn < ?'.
		stmtId := resp prepareOkay stmtHandlerId.

		stmt := MysqlDriverStmt onConnection: conn.
		stmt stmtId: stmtId; cursoredFetch: true]
	
]

{ #category : #Finalization }
MysqlSvrStmtFetchTest >> tearDown [
	super tearDown.
	stmt close
	
]

{ #category : #Tests }
MysqlSvrStmtFetchTest >> testReadAllRowsAtATime [
	| rs rd |
	stmt params: (Array with: (MysqlBindParam withValue: '2011-09-01')).
	rs := stmt execute.
	self
		assert: rs isResultSet;
		assert: rs hasOpenCursor;
		deny: rs hasLastRowSent.
	rd := stmt fetchRows: 1000.
	self
		assert: rd rows size equals: 10;
		assert: rs hasOpenCursor;
		assert: rd hasLastRowSent.
	rd := stmt fetchRows: 1.
	self assert: rd isError
]

{ #category : #Tests }
MysqlSvrStmtFetchTest >> testReadOneRowAtATime [
	| rs rd |
	stmt params: (Array with: (MysqlBindParam withValue: '2011-09-01')).
	rs := stmt execute.
	self
		assert: rs isResultSet;
		assert: rs hasOpenCursor;
		deny: rs hasLastRowSent.
	10
		timesRepeat: [ rd := stmt fetchRows: 1.
			self
				assert: rd rows size equals: 1;
				deny: rd hasLastRowSent ].
	rd := stmt fetchRows: 1.
	self
		assert: rd rows isEmpty;
		assert: rd hasLastRowSent
]

{ #category : #Tests }
MysqlSvrStmtFetchTest >> testReadSomeRowsAtATime [
	| rs rd |
	stmt params: (Array with: (MysqlBindParam withValue: '2011-09-01')).
	rs := stmt execute.
	self
		assert: rs isResultSet;
		assert: rs hasOpenCursor;
		deny: rs hasLastRowSent.
	3
		timesRepeat: [ rd := stmt fetchRows: 3.
			self
				assert: rd rows size equals: 3;
				deny: rd hasLastRowSent ].
	rd := stmt fetchRows: 3.
	self
		assert: rd rows size equals: 1;
		assert: rd hasLastRowSent
]
