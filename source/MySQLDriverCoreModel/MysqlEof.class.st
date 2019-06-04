Class {
	#name : #MysqlEof,
	#superclass : #MysqlPacket,
	#instVars : [
		'fieldCount',
		'warningCount',
		'serverStatus'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Testing }
MysqlEof >> hasLastRowSent [
	^ (serverStatus bitAnd: MysqlServerStatus statusLastRowSent) ~= 0
	
]

{ #category : #Testing }
MysqlEof >> hasMoreResults [
	^ (serverStatus bitAnd: MysqlServerStatus moreResultsExist) ~= 0
	
]

{ #category : #Testing }
MysqlEof >> hasOpenCursor [
	^ (serverStatus bitAnd: MysqlServerStatus statusCursorExists) ~= 0
	
]

{ #category : #Testing }
MysqlEof >> isEof [
	^ true
]

{ #category : #Parsing }
MysqlEof >> parse [
	fieldCount := inStream next.
	warningCount := inStream next + (inStream next bitShift: 8).
	serverStatus := inStream next + (inStream next bitShift: 8).

]

{ #category : #Accessing }
MysqlEof >> serverStatus [
	^ serverStatus 
]

{ #category : #Accessing }
MysqlEof >> warningCount [
	^ warningCount 
]
