Class {
	#name : #MysqlError,
	#superclass : #MysqlResult,
	#instVars : [
		'fieldCount',
		'errNo',
		'sqlStateMarker',
		'sqlState',
		'message'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlError >> errNo [
	^ errNo 
]

{ #category : #Testing }
MysqlError >> isError [
	^ true
]

{ #category : #Accessing }
MysqlError >> message [
	^ message 
]

{ #category : #Parsing }
MysqlError >> parse [
	fieldCount := inStream next. "always 0xFF"
	errNo := inStream next + (inStream next bitShift: 8).	
	sqlStateMarker := inStream next asCharacter. "always #"
	sqlState := (inStream next: 5) asString .
	message := inStream upToEnd asString.

]

{ #category : #Accessing }
MysqlError >> sqlState [
	^ sqlState 
]
