Class {
	#name : #MysqlBindParamStringBlobTest,
	#superclass : #TestCase,
	#instVars : [
		'theParam'
	],
	#category : 'MySQLDriverCoreTests-Unit'
}

{ #category : #Initialization }
MysqlBindParamStringBlobTest >> setUp [
	theParam := MysqlBindParam new.
	
]

{ #category : #'Test Support' }
MysqlBindParamStringBlobTest >> storeBinary [
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		^ strm contents]	
	
]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamBlob [
	theParam bindValue: (ByteArray new: 16rFF withAll: 16rAA).
	self assert: theParam detectParamType equals: MysqlTypes typeTINYBLOB.
	self assert: theParam isUnsigned.
	theParam bindValue: (ByteArray new: 16rFFFF withAll: 16r55).
	self assert: theParam detectParamType equals: MysqlTypes typeBLOB.
	self assert: theParam isUnsigned.
	theParam bindValue: (ByteArray new: 16r20000 withAll: 16rAA).
	self
		assert: theParam detectParamType
		equals: MysqlTypes typeMEDIUMBLOB.
	self assert: theParam isUnsigned.
	theParam bindValue: (ByteArray new: 16r1000000 withAll: 16r55).
	self assert: theParam detectParamType equals: MysqlTypes typeLONGBLOB.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamCharacter [
	theParam bindValue: $A.
	self assert: theParam detectParamType equals: MysqlTypes typeSTRING.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamStoreBinaryCharacter [
	theParam bindValue: $A.
	"lengthcoded + charcter as string"
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 1 with: 16r41)).

]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamStoreBinaryString [
	| value binStrm |
	theParam bindValue: 'hello'.
	"lengthcoded + string bytes"
	self
		assert:
			(self storeBinary
				hasEqualElements: (ByteArray with: 5) , 'hello' asByteArray).
	value := ''.
	10 timesRepeat: [ value := value , 'abcdefghijklmnopqrstuvwxyz' ].
	theParam bindValue: value.
	binStrm := ReadStream on: self storeBinary.
	self assert: (MysqlHelper decodeLcbFrom: binStrm) equals: 260.
	self assert: (binStrm upToEnd asString hasEqualElements: value)
]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamStoreBinarySymbol [
	theParam bindValue: #hello.
	"lengthcoded + string bytes"
	self assert: (self storeBinary hasEqualElements: 
		(ByteArray with: 5), 'hello' asByteArray).

]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamStoreBinaryText [
	theParam bindValue: (Text fromString: 'This is a text').
	"lengthcoded + string bytes"
	self assert: (self storeBinary hasEqualElements: 
		(ByteArray with: 14), 'This is a text' asByteArray).

]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamString [
	theParam bindValue: 'Smalltalk is awesome'.
	self
		assert: theParam detectParamType
		equals: MysqlTypes typeVARSTRING.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamSymbol [
	theParam bindValue: #'Symbols are special'.
	self
		assert: theParam detectParamType
		equals: MysqlTypes typeVARSTRING.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamStringBlobTest >> testParamText [
	theParam bindValue: (Text fromString: 'Smalltalk is awesome').
	self
		assert: theParam detectParamType
		equals: MysqlTypes typeVARSTRING.
	self assert: theParam isUnsigned
]
