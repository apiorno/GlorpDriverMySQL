Class {
	#name : #MysqlComplexResult,
	#superclass : #MysqlResult,
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #'Instance Creation' }
MysqlComplexResult class >> buildFrom: aSession [
	^ self subclassResponsibility 
	
]
