Class {
	#name : #MysqlOkay,
	#superclass : #MysqlResult,
	#instVars : [
		'message',
		'fieldCount',
		'affectedRows',
		'insertId',
		'warningCount',
		'serverStatus'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlOkay >> affectedRows [
	^ affectedRows 
]

{ #category : #Testing }
MysqlOkay >> hasMoreResults [
	^ (serverStatus bitAnd: MysqlServerStatus moreResultsExist) ~= 0
	
]

{ #category : #Testing }
MysqlOkay >> inTransaction [
	| autoCommit inTx |
	autoCommit := (serverStatus bitAnd: MysqlServerStatus statusInTransaction) ~= 0.
	inTx := (serverStatus bitAnd: MysqlServerStatus statusInTransaction) ~= 0.
	^ autoCommit and: [inTx]
	
]

{ #category : #Accessing }
MysqlOkay >> insertId [
	^ insertId 
]

{ #category : #Testing }
MysqlOkay >> isOkay [
	^ true
]

{ #category : #Accessing }
MysqlOkay >> message [
	^ message 
]

{ #category : #Parsing }
MysqlOkay >> parse [ 
	fieldCount := self decodeLcbFrom: inStream . "always 0"
	affectedRows := self decodeLcbFrom: inStream .
	insertId := self decodeLcbFrom: inStream .
	serverStatus := inStream next + (inStream next bitShift: 8) .
	warningCount := inStream next + (inStream next bitShift: 8) .
	message := (inStream upToEnd) asString.
	
]

{ #category : #Accessing }
MysqlOkay >> serverStatus [
	^ serverStatus 
]

{ #category : #Accessing }
MysqlOkay >> warningCount [
	^ warningCount 
]
