Class {
	#name : #MysqlComResetStmt,
	#superclass : #MysqlComBase,
	#instVars : [
		'statementId'
	],
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComResetStmt >> commandArg [
	ByteArray streamContents: [:strm |
		strm 
		nextPut: (statementId digitAt: 1);
		nextPut: (statementId digitAt: 2);
		nextPut: (statementId digitAt: 3);
		nextPut: (statementId digitAt: 4).
		
		^ strm contents]
]

{ #category : #Accessing }
MysqlComResetStmt >> commandCode [
	^ ComStmtReset 
	

]

{ #category : #Reading }
MysqlComResetStmt >> readResponse [
	| pkt |

	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [^ pkt] 
		ifFalse: [self error: 'Unrecognized response for command']
		
]

{ #category : #Accessing }
MysqlComResetStmt >> statementId: idValue [ "4 byte integer"
	statementId := idValue
	
	
]
