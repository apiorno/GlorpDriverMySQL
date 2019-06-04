Class {
	#name : #MysqlSvrStmtReadStringTest,
	#superclass : #MysqlTestCase,
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #'Test Support' }
MysqlSvrStmtReadStringTest >> scenarios [
^ '
- should read results of integer types  
	- tinyint, smallint, mediumint, (long)int, bigint
- should read results of real types 
	- float, double, real (approx values)
- should read results of real types 
	- decimal, numeric (exact values)
- should read results of date types 
	- date, time, datetime, timestamp, year
- should read results of char types 
	- char, varchar
- should read results of binary types 
	- binary, varbinary
- should read results of blob types 
	- tinyblob, blob, mediumblob longblob
- should read results of text types 
	- tinytext, text, mediumtext, longtext
'

]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadBlobTypes [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#blobs)
		do: [ :conn | 
			prep := conn
				prepare: 'select * from testBlobs where id < ? order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := Array with: (MysqlBindParam withValue: 5).
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 2.
			self assert: (resp rows first atIndex: 2) equals: '0123456789'.
			self assert: (resp rows first atIndex: 3) equals: '0123456789'.
			self assert: (resp rows first atIndex: 4) equals: '0123456789'.
			self assert: (resp rows first atIndex: 5) equals: '0123456789'.
			self assert: (resp rows second atIndex: 2) equals: '1234567890'.
			self assert: (resp rows second atIndex: 3) equals: 'NULL'.
			self assert: (resp rows second atIndex: 4) equals: 'NULL'.
			self assert: (resp rows second atIndex: 5) equals: '1234567890' ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadCharTypes [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#chars)
		do: [ :conn | 
			prep := conn
				prepare: 'select * from testChars where id < ? order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := Array with: (MysqlBindParam withValue: 5).
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 2.
			self assert: (resp rows first atIndex: 2) equals: 'smalltalk'.
			self
				assert: (resp rows first atIndex: 3)
				equals: 'An awesome programming environment'.
			self assert: (resp rows second atIndex: 2) equals: 'lisp'.
			self assert: (resp rows second atIndex: 3) equals: 'So is this one' ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadIntegerTypes [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#integers)
		do: [ :conn | 
			prep := conn prepare: 'select * from testIntegers order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 5.
			self assert: (resp rows first atIndex: 4) equals: '40000'.
			self assert: (resp rows first atIndex: 6) equals: '6000000000'.
			self assert: (resp rows second atIndex: 4) equals: '40001'.
			self assert: (resp rows second atIndex: 6) equals: '6000000001' ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadIntegerTypesNeg [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#integers)
		do: [ :conn | 
			prep := conn
				prepare: 'select * from testIntegers where tinyintValue < ? order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := MysqlBindParam
				listOfSize: prep prepareOkay numParams
				forDescriptors: prep paramDescriptors.
			params first bindValue: -100.
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 1.
			self assert: (resp rows first atIndex: 2) equals: '-101'.
			self assert: (resp rows first atIndex: 3) equals: '-301'.
			self assert: (resp rows first atIndex: 4) equals: '-40001'.
			self assert: (resp rows first atIndex: 5) equals: '-100001'.
			self assert: (resp rows first atIndex: 6) equals: '-6000000001' ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadIntegerTypesNull [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#integers)
		do: [ :conn | 
			prep := conn prepare: 'select * from testIntegers order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 5.
			self assert: (resp rows third atIndex: 4) equals: 'NULL'.
			self assert: (resp rows third atIndex: 6) equals: '6000000002'.
			self assert: (resp rows fourth atIndex: 4) equals: '40003'.
			self assert: (resp rows fourth atIndex: 6) equals: 'NULL' ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadRealTypes [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#reals)
		do: [ :conn | 
			prep := conn prepare: 'select * from testReals order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 3.
			self assert: ((resp rows first atIndex: 2) asNumber closeTo: 1.1).
			self assert: ((resp rows first atIndex: 3) asNumber closeTo: 11.11).
			self
				assert: ((resp rows first atIndex: 4) asNumber closeTo: 222.222).
			self
				assert: (resp rows first atIndex: 5)
				equals: (3333333333 / 1000000 asScaledDecimal: 6) asString.
			self
				assert: (resp rows first atIndex: 6)
				equals: (4444444444 / 1000000 asScaledDecimal: 6) asString ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadRealTypesNeg [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#reals)
		do: [ :conn | 
			prep := conn prepare: 'select * from testReals order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 3.
			self assert: ((resp rows third atIndex: 2) asNumber closeTo: -1.1).
			self
				assert: ((resp rows third atIndex: 3) asNumber closeTo: -11.11).
			self
				assert: ((resp rows third atIndex: 4) asNumber closeTo: -222.222).
			self
				assert: (resp rows third atIndex: 5)
				equals: (-3333333333 / 1000000 asScaledDecimal: 6) asString.
			self
				assert: (resp rows third atIndex: 6)
				equals: (-4444444444 / 1000000 asScaledDecimal: 6) asString ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadRealTypesNull [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#reals)
		do: [ :conn | 
			prep := conn prepare: 'select * from testReals order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 3.
			self assert: (resp rows second atIndex: 2) equals: 'NULL'.
			self assert: (resp rows second atIndex: 3) equals: 'NULL'.
			self assert: (resp rows second atIndex: 4) equals: 'NULL'.
			self assert: (resp rows second atIndex: 5) equals: 'NULL'.
			self
				assert: (resp rows second atIndex: 6)
				equals: (-5555555555 / 1000000 asScaledDecimal: 6) asString ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadTimeTypes [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#times)
		do: [ :conn | 
			prep := conn prepare: 'select * from testTimes order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 4.
			self assert: (resp rows first atIndex: 2) equals: '2011-07-01'.
			self assert: (resp rows first atIndex: 3) equals: '18:35:23'.
			self
				assert: (resp rows first atIndex: 4)
				equals: '2011-07-02 10:12'.
			self assert: (resp rows first atIndex: 5) equals: '1999'.
			self assert: (resp rows second atIndex: 2) equals: '2011-06-01'.
			self assert: (resp rows second atIndex: 3) equals: '3:17:34:22'.
			self
				assert: (resp rows second atIndex: 4)
				equals: '2011-06-02 09:11'.
			self assert: (resp rows second atIndex: 5) equals: '2000' ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadTimeTypesNeg [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#times)
		do: [ :conn | 
			prep := conn prepare: 'select * from testTimes order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 4.
			self assert: (resp rows fourth atIndex: 3) equals: '-0:16:33:21' ]
]

{ #category : #Tests }
MysqlSvrStmtReadStringTest >> testReadTimeTypesNull [
	| prep stmtId params resp stmt |
	self
		withFixtures: #(#times)
		do: [ :conn | 
			prep := conn prepare: 'select * from testTimes order by id'.
			stmtId := prep prepareOkay stmtHandlerId.
			params := #().
			stmt := MysqlDriverStmt onConnection: conn.
			stmt
				stmtId: stmtId;
				params: params;
				typeMapResults: false.
			resp := stmt execute.
			self assert: resp isResultSet.
			self assert: resp rows size equals: 4.
			self deny: (resp rows third atIndex: 1) = 'NULL'.
			self assert: (resp rows third atIndex: 2) equals: 'NULL'.
			self assert: (resp rows third atIndex: 3) equals: 'NULL'.
			self assert: (resp rows third atIndex: 4) equals: 'NULL'.
			self assert: (resp rows third atIndex: 5) equals: 'NULL' ]
]
