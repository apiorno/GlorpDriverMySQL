Class {
	#name : #MysqlComPing,
	#superclass : #MysqlComBase,
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComPing >> commandArg [
	^ nil
]

{ #category : #Accessing }
MysqlComPing >> commandCode [
	^ ComPing 
]

{ #category : #Reading }
MysqlComPing >> readResponse [
	| pkt |

	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [^ pkt] 
		ifFalse: [self error: 'Unrecognized response for command']
		
]
