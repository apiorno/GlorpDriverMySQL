Class {
	#name : #MysqlRowData,
	#superclass : #MysqlPacket,
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlRowData >> at: index [
	
	^ self atIndex: index
]

{ #category : #Accessing }
MysqlRowData >> atIndex: indx [
	self subclassResponsibility
	
]

{ #category : #Parsing }
MysqlRowData >> parse [
	self subclassResponsibility 
	
]
