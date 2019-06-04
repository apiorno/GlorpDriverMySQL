Class {
	#name : #MysqlComPrepare,
	#superclass : #MysqlComBase,
	#instVars : [
		'query'
	],
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComPrepare >> commandArg [
	^ query 
	
]

{ #category : #Accessing }
MysqlComPrepare >> commandCode [
	^ ComStmtPrepare 
	
]

{ #category : #Testing }
MysqlComPrepare >> gotEof [
	| resp |
	resp := MysqlPacket from: session peek.
	^ resp isEof 
	
]

{ #category : #Accessing }
MysqlComPrepare >> queryString: queryString [ 
	query := queryString
	
]

{ #category : #Reading }
MysqlComPrepare >> readColumnDescr [
	^ MysqlField from: session read.

]

{ #category : #Reading }
MysqlComPrepare >> readEof [
	^ MysqlEof from: session read
	
]

{ #category : #Reading }
MysqlComPrepare >> readParamDescr [
	^ MysqlField from: session read.

]

{ #category : #Reading }
MysqlComPrepare >> readPrepareOkay [
	| prepOkay params columns paramEof columnEof indx |
	
	prepOkay := MysqlPrepareOkay from: session read.
	params := Array new: prepOkay numParams.
	columns := Array new: prepOkay numColumns.
	
	prepOkay numParams > 0 ifTrue: [
		indx := 1.	
		[self gotEof] whileFalse: [
			params at: indx put: self readParamDescr.
			indx := indx + 1 ].
		paramEof := self readEof "eof"].

	prepOkay numColumns > 0 ifTrue: [	
		indx := 1.
		[self gotEof ] whileFalse: [
			columns at: indx put: self readColumnDescr.
			indx := indx + 1 ].
		columnEof := self readEof "eof"].
		
	^ MysqlPrepareResp new
		prepareOkay: prepOkay;
		paramDescriptors: params;
		paramEof: paramEof;
		columnDescriptors: columns;
		columnEof: columnEof;
		yourself
	
]

{ #category : #Reading }
MysqlComPrepare >> readResponse [
	| resp |
	resp := MysqlPacket from: session peek.
	resp isError ifTrue: [^ MysqlError from: session read].
	resp isOkay ifTrue: [^ self readPrepareOkay]

]
