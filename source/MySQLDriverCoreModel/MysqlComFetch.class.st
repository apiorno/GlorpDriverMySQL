Class {
	#name : #MysqlComFetch,
	#superclass : #MysqlComBase,
	#instVars : [
		'stmtId',
		'numRows',
		'mapResultsToNativeTypes',
		'resultSetContext'
	],
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComFetch >> commandArg [
	| |
	ByteArray streamContents: 
		[ :strm | 
		strm
			nextPut: (stmtId digitAt: 1);
			nextPut: (stmtId digitAt: 2);
			nextPut: (stmtId digitAt: 3);
			nextPut: (stmtId digitAt: 4);
			nextPut: (numRows digitAt: 1);
			nextPut: (numRows digitAt: 2);
			nextPut: (numRows digitAt: 3);
			nextPut: (numRows digitAt: 4).
			
		^ strm contents ]
]

{ #category : #Accessing }
MysqlComFetch >> commandCode [
	^ ComStmtFetch 
	
]

{ #category : #Testing }
MysqlComFetch >> gotEof [
	^ (MysqlPacket from: session peek) isEof 

]

{ #category : #Initialization }
MysqlComFetch >> initialize [
	super initialize.
	mapResultsToNativeTypes := true
	
]

{ #category : #Accessing }
MysqlComFetch >> mapResultsToNativeTypes: aBoolean [
	mapResultsToNativeTypes := aBoolean
	
]

{ #category : #Accessing }
MysqlComFetch >> numRows: count [
	numRows := count
	
]

{ #category : #Reading }
MysqlComFetch >> readEof [
	^ MysqlEof from: session read

]

{ #category : #Reading }
MysqlComFetch >> readOneRow: fields [ 
	| row |
	row := mapResultsToNativeTypes 
		ifTrue: [ MysqlBinRowData new ]
		ifFalse: [ MysqlStringRowData new ].
	row columnDescriptors: fields.
	row read: session read.
	^ row
]

{ #category : #Reading }
MysqlComFetch >> readResponse [
	| resp |
	resp := self readResult.
	^ resp
	
]

{ #category : #Reading }
MysqlComFetch >> readResult [
	| pkt fieldsEof rows fields rowsEof |
	pkt := MysqlPacket from: session peek.
	pkt isError ifTrue: [^ MysqlError from: session read].
	
	"If not error then zero or more row data packets followed by eof packet"
	fields := resultSetContext fields.
	fieldsEof := resultSetContext fieldsEof.
	fieldsEof hasOpenCursor ifTrue: [	
		rows := self readRowData: fields.
		rowsEof := self readEof. "eof"].
	
	^ resultSetContext
		rows: rows asOrderedCollection;
		rowsEof: rowsEof;
		yourself
		
]

{ #category : #Reading }
MysqlComFetch >> readRowData: fields [ 
	| respRows row |
	respRows := OrderedCollection new.
	
	[self gotEof] whileFalse: [ 
		"Read each row and save it"
		row := self readOneRow: fields.
		respRows add: row].
		
	^ respRows asArray

]

{ #category : #Accessing }
MysqlComFetch >> resultSetContext: partialResultSet [
	resultSetContext := partialResultSet 
	
]

{ #category : #Accessing }
MysqlComFetch >> statementId: id [
	stmtId := id
	
]
