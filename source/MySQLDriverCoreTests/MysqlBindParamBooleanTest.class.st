Class {
	#name : #MysqlBindParamBooleanTest,
	#superclass : #TestCase,
	#instVars : [
		'theParam'
	],
	#category : 'MySQLDriverCoreTests-Unit'
}

{ #category : #Initialization }
MysqlBindParamBooleanTest >> setUp [
	theParam := MysqlBindParam new.
	
]

{ #category : #'Test Support' }
MysqlBindParamBooleanTest >> storeBinary [
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		^ strm contents]	
	
]

{ #category : #Tests }
MysqlBindParamBooleanTest >> testParamBoolean [
	theParam bindValue: true.
	self assert: theParam detectParamType equals: MysqlTypes typeTINY.
	self assert: theParam isUnsigned.
	theParam bindValue: false.
	self assert: theParam detectParamType equals: MysqlTypes typeTINY.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamBooleanTest >> testParamStoreBinaryBoolean [
	theParam bindValue: true.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r01)).

	theParam bindValue: false.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r00)).

]
