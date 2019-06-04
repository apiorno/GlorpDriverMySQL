Class {
	#name : #MysqlPacket,
	#superclass : #Object,
	#instVars : [
		'inStream',
		'discriminator'
	],
	#classVars : [
		'CapCompress',
		'CapConnectWithDb',
		'CapFoundRows',
		'CapIgnoreSigpipe',
		'CapIgnoreSpace',
		'CapInteractive',
		'CapLocalFiles',
		'CapLongFlag',
		'CapLongPassword',
		'CapMultiResults',
		'CapMultiStatements',
		'CapNoSchema',
		'CapOdbc',
		'CapProtocol41',
		'CapReserved',
		'CapSecureConnection',
		'CapSsl',
		'CapTransactions'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #'Instance Creation' }
MysqlPacket class >> from: data [
	^ self new 
		read: data
	
]

{ #category : #Initialization }
MysqlPacket class >> initCapabilititesFlags [
	CapLongPassword := 1.
	CapFoundRows := 1 bitShift: 1.
	CapLongFlag := 1 bitShift: 2.
	CapConnectWithDb := 1 bitShift: 3.
	CapNoSchema := 1 bitShift: 4.
	CapCompress := 1 bitShift: 5.
	CapOdbc := 1 bitShift: 6.
	CapLocalFiles := 1 bitShift: 7.
	CapIgnoreSpace := 1 bitShift: 8.
	CapProtocol41 := 1 bitShift: 9.
	CapInteractive := 1 bitShift: 10.
	CapSsl := 1 bitShift: 11.
	CapIgnoreSigpipe := 1 bitShift: 12.
	CapTransactions := 1 bitShift: 13.
	CapReserved := 1 bitShift: 14.
	CapSecureConnection := 1 bitShift: 15.
	CapMultiStatements := 1 bitShift: 16.
	CapMultiResults := 1 bitShift: 17.

]

{ #category : #Initialization }
MysqlPacket class >> initialize [
	"
	self initialize
	"
	self initCapabilititesFlags.


]

{ #category : #Defaults }
MysqlPacket class >> maxNetPacketLength [
	^ MysqlNetPacket maxLength
]

{ #category : #Parsing }
MysqlPacket >> decodeLcbFrom: byteStream [ 
	^ MysqlHelper decodeLcbFrom: byteStream 
	
]

{ #category : #Parsing }
MysqlPacket >> decodeLcsFrom: aStream [ 
	^ MysqlHelper decodeLcsFrom: aStream 
	
]

{ #category : #Parsing }
MysqlPacket >> encodeLcb: value on: aStream [ 
	^ MysqlHelper encodeLcb: value on: aStream 
	
]

{ #category : #Parsing }
MysqlPacket >> encodeLcs: bytes on: aStream [
	MysqlHelper encodeLcs: bytes on: aStream
	
]

{ #category : #Testing }
MysqlPacket >> isEof [
	^ (discriminator = 16rFE) and: [inStream size < 9]

]

{ #category : #Testing }
MysqlPacket >> isError [
	^ discriminator = 16rFF

]

{ #category : #Testing }
MysqlPacket >> isOkay [
	^ discriminator = 16r00

]

{ #category : #Testing }
MysqlPacket >> isOkayOrError [
	^ self isOkay or: [self isError]
]

{ #category : #Testing }
MysqlPacket >> isPrepareResponse [
	^ false
	
]

{ #category : #Testing }
MysqlPacket >> isResultSet [
	^ false
]

{ #category : #Parsing }
MysqlPacket >> parse [
	"Default implementation; required for reading a generic (yet unknown) type of packet"
	"No parsing here; subclasses implement packet specific parsing"
	
]

{ #category : #Reading }
MysqlPacket >> read: buffer [
	discriminator := buffer first.
	inStream := ReadStream on: buffer.
	self parse
	
]

{ #category : #Writing }
MysqlPacket >> write [
	self subclassResponsibility 
]
