Class {
	#name : #MysqlComQuit,
	#superclass : #MysqlComBase,
	#category : 'MySQLDriverCoreModel-Command'
}

{ #category : #Accessing }
MysqlComQuit >> commandArg [
	^ nil
]

{ #category : #Accessing }
MysqlComQuit >> commandCode [
	^ ComQuit 
]

{ #category : #Reading }
MysqlComQuit >> readResponse [
	^ nil
		
]
