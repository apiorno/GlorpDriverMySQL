"
I am a simple facade on result set packets, although I behave as a MysqlPacketData. I don't perform a read or write; my clients compose me from specific rasult set packets. I am designed this way to facilitate use of similar metaphors at the connector protocol level. I also behave a multi-result type of packet.
"
Class {
	#name : #MysqlResultSet,
	#superclass : #MysqlComplexResult,
	#instVars : [
		'header',
		'fields',
		'fieldsEof',
		'rows',
		'rowsEof',
		'statement'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlResultSet >> fields [
	^ fields 
]

{ #category : #Accessing }
MysqlResultSet >> fields: flds [
	fields := flds
]

{ #category : #Accessing }
MysqlResultSet >> fieldsEof [
	^ fieldsEof 
]

{ #category : #Accessing }
MysqlResultSet >> fieldsEof: eofPkt [ 
	fieldsEof := eofPkt
]

{ #category : #Testing }
MysqlResultSet >> hasLastRowSent [
	"This is signaled during cursor based fetch for the rows. Therefore we
	check for the singal in the eof field following the rows in the response."
	^ rowsEof ifNil: [false] ifNotNil: [rowsEof hasLastRowSent]
	
]

{ #category : #Testing }
MysqlResultSet >> hasMoreResults [
	"Looks like the flag, when set, will be set by the server in both the
	field eof and rowdata eof packets. We are only using field eof here, since
	rowdata eof may not sometimes sent as part of the result set (e.g., cursor)."
	^ fieldsEof hasMoreResults
	
]

{ #category : #Testing }
MysqlResultSet >> hasOpenCursor [
	^ fieldsEof hasOpenCursor 
	
]

{ #category : #Accessing }
MysqlResultSet >> header [
	^ header
]

{ #category : #Accessing }
MysqlResultSet >> header: hdr [
	header := hdr
]

{ #category : #Testing }
MysqlResultSet >> isResultSet [
	^ true
]

{ #category : #Executing }
MysqlResultSet >> nextRow [
		
	(self rows isEmptyOrNil and: [self hasOpenCursor and: [self hasLastRowSent not]])
			ifTrue: [ statement fetchRows: statement fetchSize ].
			
	^ rows ifEmpty: [ nil ] ifNotEmpty: [ rows removeFirst ]
]

{ #category : #Parsing }
MysqlResultSet >> parse [
	self shouldNotImplement
	
]

{ #category : #Accessing }
MysqlResultSet >> rows [
	^ rows
]

{ #category : #Accessing }
MysqlResultSet >> rows: allRows [
	rows := allRows
	
]

{ #category : #Accessing }
MysqlResultSet >> rowsEof [
	^ rowsEof 
]

{ #category : #Accessing }
MysqlResultSet >> rowsEof: eofPkt [
	rowsEof := eofPkt
]

{ #category : #Accessing }
MysqlResultSet >> serverStatus [
	^ fieldsEof serverStatus
	
]

{ #category : #Accessing }
MysqlResultSet >> statement: aStatement [ 
	
	statement := aStatement
]
