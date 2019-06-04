Class {
	#name : #MysqlBindParamRealTest,
	#superclass : #TestCase,
	#instVars : [
		'theParam'
	],
	#category : 'MySQLDriverCoreTests-Unit'
}

{ #category : #Initialization }
MysqlBindParamRealTest >> setUp [
	theParam := MysqlBindParam new
	
]

{ #category : #'Test Support' }
MysqlBindParamRealTest >> storeBinary [
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		^ strm contents]	
]

{ #category : #Tests }
MysqlBindParamRealTest >> testParamDecimal [
	theParam bindValue: 12345.678901s6.
	self assert: theParam paramType equals: MysqlTypes typeDECIMAL.
	self assert: theParam isUnsigned.
	theParam bindValue: -12345.678901s6.
	self assert: theParam paramType equals: MysqlTypes typeDECIMAL.
	self deny: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamRealTest >> testParamDouble [
	theParam bindValue: 123456789123456789.123456789.
	self assert: theParam paramType equals: MysqlTypes typeDOUBLE.
	self assert: theParam isUnsigned.
	theParam bindValue: -123456789123456789.123456789.
	self assert: theParam paramType equals: MysqlTypes typeDOUBLE.
	self deny: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamRealTest >> testParamFloat [
	theParam bindValue: 65.0.
	self assert: theParam paramType equals: MysqlTypes typeFLOAT.
	self assert: theParam isUnsigned.
	theParam bindValue: -65.0.
	self assert: theParam paramType equals: MysqlTypes typeFLOAT.
	self deny: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamRealTest >> testParamFraction [
	theParam bindValue: 100 / 3.
	self assert: theParam paramType equals: MysqlTypes typeDOUBLE.
	self assert: theParam isUnsigned.
	theParam bindValue: -100 / 3.
	self assert: theParam paramType equals: MysqlTypes typeDOUBLE.
	self deny: theParam isUnsigned.
	theParam bindValue: 17 / 4.
	self assert: theParam paramType equals: MysqlTypes typeFLOAT.
	self assert: theParam isUnsigned.
	theParam bindValue: -17 / 4.
	self assert: theParam paramType equals: MysqlTypes typeFLOAT.
	self deny: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamRealTest >> testStoreBinarySignedDecimal [
	theParam bindValue: -12345.678901s6.
	ByteArray
		streamContents: [ :strm | 
			theParam storeBinaryOn: strm.
			self assert: strm contents asString equals: '12345.678901' ]
]

{ #category : #Tests }
MysqlBindParamRealTest >> testStoreBinarySignedDouble [
	theParam bindValue: -123456789123456789.123456789.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: 
				(MysqlHelper bytesFromHexString: 'B4697BC3F105CDBA'))]
			
]

{ #category : #Tests }
MysqlBindParamRealTest >> testStoreBinarySignedFraction [
	theParam bindValue: -17/4.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: (MysqlHelper bytesFromHexString: '000011C0'))]
		
]

{ #category : #Tests }
MysqlBindParamRealTest >> testStoreBinarySingedFloat [
	theParam bindValue: -65.0.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: (MysqlHelper bytesFromHexString: '004050C0'))]
		
]

{ #category : #Tests }
MysqlBindParamRealTest >> testStoreBinaryUnsignedDecimal [
	theParam bindValue: 12345.678901s6.
	ByteArray
		streamContents: [ :strm | 
			theParam storeBinaryOn: strm.
			self assert: strm contents asString equals: '12345.678901' ]
]

{ #category : #Tests }
MysqlBindParamRealTest >> testStoreBinaryUnsignedDouble [
	theParam bindValue: 123456789123456789.123456789.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: (MysqlHelper bytesFromHexString: 'B4697B43F105CDBA'))]
		
]

{ #category : #Tests }
MysqlBindParamRealTest >> testStoreBinaryUnsignedFloat [
	theParam bindValue: 65.0.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: (MysqlHelper bytesFromHexString: '00405040'))]
		
]

{ #category : #Tests }
MysqlBindParamRealTest >> testStoreBinaryUnsignedFraction [
	theParam bindValue: 17/4.
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		self assert: (strm contents 
			hasEqualElements: (MysqlHelper bytesFromHexString: '00001140'))]
		
]
