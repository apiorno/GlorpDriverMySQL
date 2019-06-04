Class {
	#name : #MysqlField,
	#superclass : #MysqlPacket,
	#instVars : [
		'catalog',
		'db',
		'table',
		'orgTable',
		'name',
		'orgName',
		'charSet',
		'type',
		'flags',
		'default',
		'decimals',
		'length'
	],
	#classVars : [
		'AutoIncrFlag',
		'BinaryFlag',
		'BlobFlag',
		'EnumFlag',
		'MultiKeyFlag',
		'NotNullFlag',
		'PrimaryKeyFlag',
		'SetFlag',
		'UniqueKeyFlag',
		'UnsignedFlag',
		'ZeroFillFlag'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Initialization }
MysqlField class >> initBitMasksForFlags [

	NotNullFlag := 16r0001.
	PrimaryKeyFlag := 16r0002.
	UniqueKeyFlag := 16r0004.
	MultiKeyFlag := 16r0008.
	BlobFlag := 16r0010.
	UnsignedFlag := 16r0020.
	ZeroFillFlag := 16r0040.
	BinaryFlag := 16r0080.
	EnumFlag := 16r0100.
	AutoIncrFlag := 16r0200.
	SetFlag := 16r0800.
	
	

]

{ #category : #Initialization }
MysqlField class >> initialize [
	"self initialize"
	self initBitMasksForFlags.
	
]

{ #category : #Accessing }
MysqlField >> db [
	^ db
	
]

{ #category : #Accessing }
MysqlField >> decimals [
	^ decimals 
]

{ #category : #Testing }
MysqlField >> isAutoIncrement [
	^ (flags bitAnd: AutoIncrFlag) = AutoIncrFlag   
	
]

{ #category : #Testing }
MysqlField >> isNullable [
	^ (flags bitAnd: NotNullFlag) ~= NotNullFlag  
	
]

{ #category : #Testing }
MysqlField >> isPrimaryKey [
	^ (flags bitAnd: PrimaryKeyFlag) = PrimaryKeyFlag  
	
]

{ #category : #Testing }
MysqlField >> isUnsigned [
	^ (flags bitAnd: UnsignedFlag) = UnsignedFlag 
	
]

{ #category : #Accessing }
MysqlField >> length [
	^ length 
	
]

{ #category : #Accessing }
MysqlField >> name [
	^ name
	
]

{ #category : #Parsing }
MysqlField >> parse [
	catalog := (self decodeLcsFrom: inStream) asString.
	db := (self decodeLcsFrom: inStream) asString.
	table := (self decodeLcsFrom: inStream) asString.
	orgTable := (self decodeLcsFrom: inStream) asString.
	name := (self decodeLcsFrom: inStream) asString.
	orgName := (self decodeLcsFrom: inStream) asString.
	inStream next. "filler"
	charSet := inStream next + (inStream next bitShift: 8).
	length := inStream next + (inStream next bitShift: 8) + 
		(inStream next bitShift: 16) + (inStream next bitShift: 24).
	type := inStream next.
	flags := inStream next + (inStream next bitShift: 8).
	decimals := inStream next.
	inStream next; next. "2 filler"
	"The field default only appears for table definitions, not for normal resultsets"
	inStream atEnd ifFalse: [default := self decodeLcbFrom: inStream].
	
]

{ #category : #Accessing }
MysqlField >> table [
	^ table
	
]

{ #category : #Accessing }
MysqlField >> type [
	^ type
	
]
