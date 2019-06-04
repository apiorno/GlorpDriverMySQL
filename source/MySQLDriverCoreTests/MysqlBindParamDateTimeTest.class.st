Class {
	#name : #MysqlBindParamDateTimeTest,
	#superclass : #TestCase,
	#instVars : [
		'theParam'
	],
	#category : 'MySQLDriverCoreTests-Unit'
}

{ #category : #Initialization }
MysqlBindParamDateTimeTest >> setUp [
	theParam := MysqlBindParam new.
	
]

{ #category : #'Test Support' }
MysqlBindParamDateTimeTest >> storeBinary [
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		^ strm contents]	
	
]

{ #category : #Tests }
MysqlBindParamDateTimeTest >> testParamDate [
	theParam bindValue: (Date fromString: '06-21-2011').
	self assert: theParam detectParamType equals: MysqlTypes typeDATE.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamDateTimeTest >> testParamDateTime [
	theParam bindValue: DateAndTime current.
	self assert: theParam detectParamType equals: MysqlTypes typeDATETIME.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamDateTimeTest >> testParamDuration [
	theParam bindValue: (Duration fromString: '10:02:30:45').
	self assert: theParam detectParamType equals: MysqlTypes typeTIME.
	self assert: theParam isUnsigned.
	theParam bindValue: (Duration fromString: '-10:02:30:45').
	self assert: theParam detectParamType equals: MysqlTypes typeTIME.
	self assert: theParam isUnsigned not
]

{ #category : #Tests }
MysqlBindParamDateTimeTest >> testParamTime [
	theParam bindValue: Time now.
	self assert: theParam detectParamType equals: MysqlTypes typeTIME.
	self assert: theParam isUnsigned
]

{ #category : #Tests }
MysqlBindParamDateTimeTest >> testStoreBinaryDate [
	theParam bindValue: (Date fromString: '06-21-2011').
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '04DB070615'
]

{ #category : #Tests }
MysqlBindParamDateTimeTest >> testStoreBinaryDateAndTime [
	theParam bindValue: DateAndTime epoch.	"Squeak epoch: 1901-01-01"
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '046D070101'.
	theParam
		bindValue: (DateAndTime fromString: '2011-06-21T16:45:30.00000000').
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '07DB070615102D1E'.
	theParam
		bindValue: (DateAndTime fromString: '2011-06-21T16:45:30.00123456').
	"Since the microseconds are stored form the nano (1234 from 1234560 ns)"
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '0BDB070615102D1ED2040000'
]

{ #category : #Tests }
MysqlBindParamDateTimeTest >> testStoreBinaryDuration [
	theParam bindValue: Duration zero.
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '00'.
	theParam bindValue: (Duration fromString: '10:02:30:45').
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '08000A000000021E2D'.
	theParam bindValue: (Duration fromString: '-10:02:30:45').
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '08010A000000021E2D'.
	theParam bindValue: (Duration fromString: '10:02:30:45.1234').
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '0C000A000000021E2D08E20100'
]

{ #category : #Tests }
MysqlBindParamDateTimeTest >> testStoreBinaryTime [
	theParam bindValue: Time midnight.
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '00'.
	theParam bindValue: (Time fromString: '16:02:30').
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '08000000000010021E'.
	theParam
		bindValue:
			(Time
				hour: 16
				minute: 02
				second: 30
				nanoSecond: 1234000).
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '0C000000000010021ED2040000'
]
