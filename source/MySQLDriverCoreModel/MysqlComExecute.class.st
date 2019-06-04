Class {
	#name : #MysqlComExecute,
	#superclass : #MysqlComBase,
	#instVars : [
		'stmtId',
		'params',
		'cursoredFetch',
		'mapResultsToNativeTypes'
	],
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComExecute >> commandArg [
	| paramType nonLongs |
	ByteArray streamContents: 
		[ :strm | 
		strm
			nextPut: (stmtId digitAt: 1);
			nextPut: (stmtId digitAt: 2);
			nextPut: (stmtId digitAt: 3);
			nextPut: (stmtId digitAt: 4).
		cursoredFetch 
			ifTrue: [ strm nextPut: 1	"flags => READ_CURSOR" ]
			ifFalse: [ strm nextPut: 0	"flags => NO_CURSOR" ].
		strm
			nextPut: 1;
			nextPut: 0;
			nextPut: 0;
			nextPut: 0.	"iterationCount"
		strm nextPutAll: self nullBitMap.
		self hasNewParamBound 
			ifTrue: 
				[ strm nextPut: 1.	"new params bound <- true"
				params do: 
					[ :each | 
					paramType := each paramType.
					strm
						nextPut: (paramType digitAt: 1);
						nextPut: (paramType digitAt: 2) ] ]
			ifFalse: [ strm nextPut: 0 ].	"new params bound <- false"
		nonLongs := params 
			ifNil: [ Array new ]
			ifNotNil: [ params reject: [ :each | each isLongData ] ].
		nonLongs do: [ :each | each storeBinaryOn: strm ].
		^ strm contents ]
]

{ #category : #Accessing }
MysqlComExecute >> commandCode [
	^ ComStmtExecute 
	
]

{ #category : #Accessing }
MysqlComExecute >> cursoredFetch: aBoolean [ 
	cursoredFetch := aBoolean
	
]

{ #category : #Executing }
MysqlComExecute >> execute [
	| resp |
	"Remember to send long data for the longdata params before calling here"
	resp := super execute.
	self resetNewParamBound.
	^ resp
	
]

{ #category : #Testing }
MysqlComExecute >> gotEof [
	^ (MysqlPacket from: session peek) isEof 

]

{ #category : #Testing }
MysqlComExecute >> hasNewParamBound [
	^ params anySatisfy: [:each | each isRebound]
	
]

{ #category : #Initialization }
MysqlComExecute >> initialize [
	super initialize.
	cursoredFetch := false.
	mapResultsToNativeTypes := true
	
]

{ #category : #Accessing }
MysqlComExecute >> mapResultsToNativeTypes: aBoolean [
	mapResultsToNativeTypes := aBoolean
	
]

{ #category : #Accessing }
MysqlComExecute >> nullBitMap [
	| nullBitMap mapByte byteIndex bitMask |
	nullBitMap := ByteArray new: (params size + 7) // 8.
	params doWithIndex: [:each :paramIndex |
		each isNull ifTrue: [
			byteIndex := (paramIndex + 7) // 8.
			bitMask := 1 bitShift: (paramIndex + 7) \\ 8.
			mapByte := nullBitMap at: byteIndex.
			mapByte := mapByte bitOr: bitMask.
			nullBitMap at: byteIndex put: mapByte.
		]
	].

	^ nullBitMap 
	
]

{ #category : #Accessing }
MysqlComExecute >> params: inParams [
	params := inParams.
	
]

{ #category : #Reading }
MysqlComExecute >> readEof [
	^ MysqlEof from: session read

]

{ #category : #Reading }
MysqlComExecute >> readFields [
	| respFields field |
	respFields := OrderedCollection new.
	
	[self gotEof] whileFalse:[ 
		"Read each field and save it"
		field := self readOneField.
		respFields add: field ].
		
	^ respFields asArray
			
]

{ #category : #Reading }
MysqlComExecute >> readOneField [
	^ MysqlField from: session read.

]

{ #category : #Reading }
MysqlComExecute >> readOneRow: fields [ 
	| row |
	row := mapResultsToNativeTypes 
		ifTrue: [ MysqlBinRowData new ]
		ifFalse: [ MysqlStringRowData new ].
	row columnDescriptors: fields.
	row read: session read.
	^ row
]

{ #category : #Reading }
MysqlComExecute >> readResponse [
	| resp |
	resp := self readResult.
	"We do not need to look for multi-result responses in statement execute; so the following
	line of code is commented out. Check COM_QUERY response handling for multi-result"
	"resp hasMoreResults ifTrue: [resp next: self readResponse]."
	^ resp
	
]

{ #category : #Reading }
MysqlComExecute >> readResult [
	| resultSetHdr pkt fieldsEof rows fields rowsEof |
	pkt := super readResponse.
	pkt isOkayOrError ifTrue: [^ pkt].
	
	resultSetHdr := MysqlResultSetHeader from: session read.
	fields := self readFields.
	fieldsEof := self readEof.	"eof"

	fieldsEof hasOpenCursor ifFalse: [	
		rows := self readRowData: fields.
		rowsEof := self readEof. "eof"].
	
	^ MysqlResultSet new
		header: resultSetHdr;
		fields: fields;
		fieldsEof: fieldsEof;
		rows: rows;
		rowsEof: rowsEof;
		yourself
]

{ #category : #Reading }
MysqlComExecute >> readRowData: fields [ 
	| respRows row |
	respRows := OrderedCollection new.
	
	[self gotEof] whileFalse: [ 
		"Read each row and save it"
		row := self readOneRow: fields.
		respRows add: row].
		
	^ respRows asArray

]

{ #category : #Initialization }
MysqlComExecute >> resetNewParamBound [
	params do: [:each | each resetReboundFlag]
	
]

{ #category : #Accessing }
MysqlComExecute >> statementId: id [
	stmtId := id
	
]
