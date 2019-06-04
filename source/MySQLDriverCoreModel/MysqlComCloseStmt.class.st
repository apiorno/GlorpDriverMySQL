Class {
	#name : #MysqlComCloseStmt,
	#superclass : #MysqlComBase,
	#instVars : [
		'statementId'
	],
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComCloseStmt >> commandArg [
	ByteArray streamContents: [:strm |
		strm 
		nextPut: (statementId digitAt: 1);
		nextPut: (statementId digitAt: 2);
		nextPut: (statementId digitAt: 3);
		nextPut: (statementId digitAt: 4).
		
		^ strm contents]
]

{ #category : #Accessing }
MysqlComCloseStmt >> commandCode [
	^ ComStmtClose
	

]

{ #category : #Reading }
MysqlComCloseStmt >> readResponse [
	^ nil
	
]

{ #category : #Accessing }
MysqlComCloseStmt >> statementId: idValue [ "4 byte integer"
	statementId := idValue
	
	
]
