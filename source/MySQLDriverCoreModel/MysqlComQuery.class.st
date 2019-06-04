Class {
	#name : #MysqlComQuery,
	#superclass : #MysqlComBase,
	#instVars : [
		'query'
	],
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComQuery >> commandArg [
	^ query 
]

{ #category : #Accessing }
MysqlComQuery >> commandCode [
	^ ComQuery 
]

{ #category : #Testing }
MysqlComQuery >> gotEof [
	^ (MysqlPacket from: session peek) isEof 
	
]

{ #category : #Accessing }
MysqlComQuery >> queryString: queryString [ 
	query := queryString
]

{ #category : #Reading }
MysqlComQuery >> readEof [
	^ MysqlEof from: session read

]

{ #category : #Reading }
MysqlComQuery >> readFields [
	| respFields field |
	respFields := OrderedCollection new.
	
	[self gotEof] whileFalse:[ 
		"Read each field and save it"
		field := self readOneField.
		respFields add: field ].
		
	^ respFields asArray
	
]

{ #category : #Reading }
MysqlComQuery >> readOneField [
	^ MysqlField from: session read
	
]

{ #category : #Reading }
MysqlComQuery >> readOneRow: fieldCount [
	| row |
	row := MysqlQueryRowData new.
	row columnCount: fieldCount.
	row read: session read.
	^ row
	
]

{ #category : #Reading }
MysqlComQuery >> readResponse [
	| resp |
	resp := self readResult.
	resp hasMoreResults ifTrue: [resp nextResult: self readResponse].
	^ resp
]

{ #category : #Reading }
MysqlComQuery >> readResult [
	| fields fieldsEof rows rowsEof resultSetHdr pkt |
	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [ ^ pkt ]
		ifFalse: [ resultSetHdr := self readRsHeader ].
	fields := self readFields.
	fieldsEof := self readEof.
	rows := self readRowData: resultSetHdr fieldCount.
	rowsEof := self readEof.
	^ MysqlResultSet new
		header: resultSetHdr;
		fields: fields;
		fieldsEof: fieldsEof;
		rows: rows;
		rowsEof: rowsEof;
		yourself
]

{ #category : #Reading }
MysqlComQuery >> readRowData: fieldCount [ 
	| respRows row |
	respRows := OrderedCollection new.
	
	[self gotEof] whileFalse: [ 
		"Read each field and save it"
		row := self readOneRow: fieldCount.
		respRows add: row].
		
	^ respRows asArray
	
]

{ #category : #Reading }
MysqlComQuery >> readRsHeader [
	^ MysqlResultSetHeader from: session read
	
]
