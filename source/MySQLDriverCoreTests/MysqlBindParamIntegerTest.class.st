Class {
	#name : #MysqlBindParamIntegerTest,
	#superclass : #TestCase,
	#instVars : [
		'theParam'
	],
	#category : 'MySQLDriverCoreTests-Unit'
}

{ #category : #Initialization }
MysqlBindParamIntegerTest >> setUp [
	theParam := MysqlBindParam new.
	
]

{ #category : #'Test Support' }
MysqlBindParamIntegerTest >> specText [
	"
	Binding an integer in range -128 to 255
		- should set the param type to TINY		
	Binding an integer in range -128 to -1
		- should produce a 2's complement byte array of size 1 in binary protocol'
	Binding an integer in range 0 to 255
		- should produce a byte array of size 1 in binary protocol'
	"

]

{ #category : #'Test Support' }
MysqlBindParamIntegerTest >> storeBinary [
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		^ strm contents]	
	
]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testParamInBigIntRange [
	theParam bindValue: -16r8000000000000000.
	self assert: theParam paramType equals: MysqlTypes typeLONGLONG.
	self deny: theParam isUnsigned.
	theParam bindValue: -16r80000001.
	self assert: theParam paramType equals: MysqlTypes typeLONGLONG.
	self deny: theParam isUnsigned.
	theParam bindValue: 16r100000000.
	self assert: theParam paramType equals: MysqlTypes typeLONGLONG.
	self assert: theParam isUnsigned.
	self
		should: [ theParam bindValue: 16rFFFFFFFFFFFFFFFF ]
		raise: MysqlBindError.
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFFFFFFFFFFFFFF.
	self assert: theParam paramType equals: MysqlTypes typeLONGLONG.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testParamInLongIntRange [
	theParam bindValue: -16r80000000.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self deny: theParam isUnsigned.
	theParam bindValue: -16r8001.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self deny: theParam isUnsigned.
	theParam bindValue: 16r10000.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self assert: theParam isUnsigned.
	theParam bindValue: 16rFFFFFFFF.
	self assert: theParam paramType equals: MysqlTypes typeLONGLONG.
	self assert: theParam isUnsigned.
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFFFFFF.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testParamInShortIntRange [
	theParam bindValue: -16r8000.
	self assert: theParam paramType equals: MysqlTypes typeSHORT.
	self deny: theParam isUnsigned.
	theParam bindValue: -16r81.
	self assert: theParam paramType equals: MysqlTypes typeSHORT.
	self deny: theParam isUnsigned.
	theParam bindValue: 16r100.
	self assert: theParam paramType equals: MysqlTypes typeSHORT.
	self assert: theParam isUnsigned.
	theParam bindValue: 16rFFFF.
	self assert: theParam paramType equals: MysqlTypes typeLONG.
	self assert: theParam isUnsigned.
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFF.
	self assert: theParam paramType equals: MysqlTypes typeSHORT.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testParamInTinyIntRange [
	theParam bindValue: -128.
	self assert: theParam paramType equals: MysqlTypes typeTINY.
	theParam bindValue: 0.
	self assert: theParam paramType equals: MysqlTypes typeTINY.
	theParam bindValue: 255.
	self assert: theParam paramType equals: MysqlTypes typeSHORT
]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testParamOutOfBigIntRange [
	self should: [theParam bindValue: -16r8000000000000001] raise: MysqlBindError.
	theParam bindValue: -16r80000000.
	self deny: (theParam paramType = MysqlTypes typeLONGLONG).
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFFFFFF.
	self deny: (theParam paramType = MysqlTypes typeLONGLONG).
	self should: [theParam bindValue: 16r10000000000000000] raise: MysqlBindError.

]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testParamOutOfLongIntRange [
	theParam bindValue: -16r80000001.
	self deny: (theParam paramType = MysqlTypes typeLONG).
	theParam bindValue: -16r8000.
	self deny: (theParam paramType = MysqlTypes typeLONG).
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFF.
	self deny: (theParam paramType = MysqlTypes typeLONG).
	theParam bindValue: 16r100000000.
	self deny: (theParam paramType = MysqlTypes typeLONG).

]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testParamOutOfShortIntRange [
	theParam bindValue: -16r8001.
	self deny: (theParam paramType = MysqlTypes typeSHORT).
	theParam bindValue: -16r80.
	self deny: (theParam paramType = MysqlTypes typeSHORT).
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFF.
	self deny: (theParam paramType = MysqlTypes typeSHORT).
	theParam bindValue: 16r10000.
	self deny: (theParam paramType = MysqlTypes typeSHORT).

]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testParamOutOfTinyIntRange [
	theParam bindValue: -129.
	self deny: (theParam paramType = MysqlTypes typeTINY).
	theParam bindValue: 256.
	self deny: (theParam paramType = MysqlTypes typeTINY).

]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testStoreBinaryBigInt [
	theParam bindValue: -16r8000000000000000.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: '0000000000000080')).

	theParam bindValue: -16r80000001.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: 'FFFFFF7FFFFFFFFF')).

	theParam bindValue: 16r100000000.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: '0000000001000000')).

	self should: [theParam bindValue: 16rFFFFFFFFFFFFFFFF] raise: MysqlBindError.
	theParam declaredUnsigned: true.	
	theParam bindValue: 16rFFFFFFFFFFFFFFFF.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: 'FFFFFFFFFFFFFFFF')).

]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testStoreBinaryLongInt [
	theParam bindValue: -16r80000000.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: '00000080')).

	theParam bindValue: -16r8001.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: 'FF7FFFFF')).

	theParam bindValue: 16r10000.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: '00000100')).

	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFFFFFF.
	self assert: (self storeBinary hasEqualElements: 
		(MysqlHelper bytesFromHexString: 'FFFFFFFF')).
	
]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testStoreBinaryShortInt [
	theParam bindValue: -16r8000.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r00 with: 16r80)).
	theParam bindValue: -16r81.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r7F with: 16rFF)).

	theParam bindValue: 16r100.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r00 with: 16r01)).
	theParam declaredUnsigned: true.
	theParam bindValue: 16rFFFF.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16rFF with: 16rFF)).
	
]

{ #category : #Tests }
MysqlBindParamIntegerTest >> testStoreBinaryTinyInt [
	theParam bindValue: -128.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r80)).
	theParam bindValue: -1.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16rFF)).

	theParam bindValue: 0.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16r00)).
	theParam declaredUnsigned: true.
	theParam bindValue: 255.
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 16rFF)).
	
]
