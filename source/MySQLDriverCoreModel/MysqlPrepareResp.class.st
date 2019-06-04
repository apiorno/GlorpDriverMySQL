Class {
	#name : #MysqlPrepareResp,
	#superclass : #MysqlComplexResult,
	#instVars : [
		'prepareOkay',
		'paramDescriptors',
		'paramEof',
		'columnDescriptors',
		'columnEof'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlPrepareResp >> columnDescriptors [
	^ columnDescriptors
	
]

{ #category : #Accessing }
MysqlPrepareResp >> columnDescriptors: fields [
	columnDescriptors := fields 
	
]

{ #category : #Accessing }
MysqlPrepareResp >> columnEof: anEof [
	columnEof := anEof
	
]

{ #category : #Testing }
MysqlPrepareResp >> isOkay [
	^ prepareOkay isOkay 
	
]

{ #category : #Testing }
MysqlPrepareResp >> isPrepareResponse [
	^ true
	
]

{ #category : #Accessing }
MysqlPrepareResp >> paramDescriptors [
	^ paramDescriptors
	 
	
]

{ #category : #Accessing }
MysqlPrepareResp >> paramDescriptors: fields [
	paramDescriptors := fields 
	
]

{ #category : #Accessing }
MysqlPrepareResp >> paramEof: anEof [
	paramEof := anEof 
	
]

{ #category : #Accessing }
MysqlPrepareResp >> prepareOkay [
	^ prepareOkay
	
]

{ #category : #Accessing }
MysqlPrepareResp >> prepareOkay: prepOkay [
	prepareOkay := prepOkay
	
]
