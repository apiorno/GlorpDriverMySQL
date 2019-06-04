Class {
	#name : #MysqlPrepareOkay,
	#superclass : #MysqlPacket,
	#instVars : [
		'warningCount',
		'numColumns',
		'numParams',
		'stmtId'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Testing }
MysqlPrepareOkay >> isOkay [
	^ true
	
]

{ #category : #Accessing }
MysqlPrepareOkay >> numColumns [
	^ numColumns
]

{ #category : #Accessing }
MysqlPrepareOkay >> numParams [
	^ numParams
]

{ #category : #Parsing }
MysqlPrepareOkay >> parse [ 
	inStream next.	"always 0, marker for oaky pakcet"
	stmtId := inStream next + (inStream next bitShift: 8) + 
			(inStream next bitShift: 16) + (inStream next bitShift: 24).
	numColumns := inStream next + (inStream next bitShift: 8).
	numParams := inStream next + (inStream next bitShift: 8).
	inStream next.	"filler, always 0"
	warningCount := inStream next + (inStream next bitShift: 8)
	
]

{ #category : #Accessing }
MysqlPrepareOkay >> stmtHandlerId [
	^ stmtId
]

{ #category : #Accessing }
MysqlPrepareOkay >> warningCount [
	^ warningCount
	
]
