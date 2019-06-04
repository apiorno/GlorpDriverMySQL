Class {
	#name : #MysqlComLongData,
	#superclass : #MysqlComBase,
	#instVars : [
		'dataBytes',
		'statementId',
		'paramNum'
	],
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComLongData >> commandArg [
	ByteArray streamContents: [:strm |
		strm 
			nextPut: (statementId digitAt: 1);
			nextPut: (statementId digitAt: 2);
			nextPut: (statementId digitAt: 3);
			nextPut: (statementId digitAt: 4).
		strm 
			nextPut: (paramNum digitAt: 1);
			nextPut: (paramNum digitAt: 2).
		strm nextPutAll: dataBytes.
		^ strm contents]
	
]

{ #category : #Accessing }
MysqlComLongData >> commandCode [
	^ ComStmtSendLongData 
	
]

{ #category : #Accessing }
MysqlComLongData >> dataBytes: aByteArray [
	dataBytes := aByteArray 
	
]

{ #category : #Accessing }
MysqlComLongData >> paramNum: aNumber [
	paramNum := aNumber
	
]

{ #category : #Reading }
MysqlComLongData >> readResponse [
	"This command does not hae any response from server"
	^ nil
	
]

{ #category : #Accessing }
MysqlComLongData >> statementId: anId [
	statementId := anId
	
]
