Class {
	#name : #MysqlTypes,
	#superclass : #Object,
	#classVars : [
		'TypeBIT',
		'TypeBLOB',
		'TypeDATE',
		'TypeDATETIME',
		'TypeDECIMAL',
		'TypeDOUBLE',
		'TypeENUM',
		'TypeFLOAT',
		'TypeGEOMETRY',
		'TypeINT24',
		'TypeLONG',
		'TypeLONGBLOB',
		'TypeLONGLONG',
		'TypeMEDIUMBLOB',
		'TypeNEWDATE',
		'TypeNEWDECIMAL',
		'TypeNULL',
		'TypeSET',
		'TypeSHORT',
		'TypeSTRING',
		'TypeTIME',
		'TypeTIMESTAMP',
		'TypeTINY',
		'TypeTINYBLOB',
		'TypeVARCHAR',
		'TypeVARSTRING',
		'TypeYEAR'
	],
	#classInstVars : [
		'blobTypes',
		'dateTimeTypes',
		'integerTypes',
		'stringTypes',
		'realTypes'
	],
	#category : 'MySQLDriverCoreModel-Helper'
}

{ #category : #Accessing }
MysqlTypes class >> blobTypes [
	blobTypes ifNil: [
		blobTypes := Array 
			with: TypeTINYBLOB with: TypeMEDIUMBLOB with: TypeBLOB with: TypeLONGBLOB ].
	^ blobTypes
	
]

{ #category : #Accessing }
MysqlTypes class >> dateTimeTypes [
	dateTimeTypes ifNil: [
		dateTimeTypes := Array 
			with: TypeDATE with: TypeDATETIME with: TypeNEWDATE with: TypeTIME
			"with: TypeTIMESTAMP" with: TypeYEAR
		].
	^ dateTimeTypes
	
]

{ #category : #Initialization }
MysqlTypes class >> initFieldTypes [
 	TypeBIT := 16.
 	TypeBLOB := 252.
 	TypeDATE := 10.
 	TypeDATETIME := 12.
 	TypeDECIMAL := 0.
 	TypeDOUBLE := 5.
 	TypeENUM := 247.
 	TypeFLOAT := 4.
 	TypeGEOMETRY := 255.
 	TypeINT24 := 9.
 	TypeLONG := 3.
 	TypeLONGLONG := 8.
 	TypeLONGBLOB := 251.
 	TypeMEDIUMBLOB := 250.
 	TypeNEWDATE := 14.
 	TypeNEWDECIMAL := 246.
 	TypeNULL := 6.
 	TypeSET := 248.
 	TypeSHORT := 2.
 	TypeSTRING := 254.
 	TypeTIME := 11.
 	"TypeTIMESTAMP := 7."
 	TypeTINY := 1.
 	TypeTINYBLOB := 249.
 	TypeVARCHAR := 15.
 	TypeVARSTRING := 253.
 	TypeYEAR := 13.

]

{ #category : #Initialization }
MysqlTypes class >> initialize [
	"self initialize"

	self initFieldTypes.

]

{ #category : #Accessing }
MysqlTypes class >> integerTypes [
	integerTypes ifNil: [
		integerTypes := Array 
			with: TypeTINY with: TypeSHORT with: TypeINT24 with: TypeLONG 
			with: TypeLONGLONG].
	^ integerTypes
	
]

{ #category : #Testing }
MysqlTypes class >> isBigInt: type [
	^ type = TypeLONGLONG
	
]

{ #category : #Testing }
MysqlTypes class >> isLongInt: type [
	^ type = TypeLONG
	
]

{ #category : #Testing }
MysqlTypes class >> isMediumInt: type [
	^ type = TypeINT24
	
]

{ #category : #Testing }
MysqlTypes class >> isSmallInt: type [
	^ type = TypeSHORT
	
]

{ #category : #Testing }
MysqlTypes class >> isTinyInt: type [
	^ type = TypeTINY
	
]

{ #category : #Accessing }
MysqlTypes class >> realTypes [
	realTypes ifNil: [
		realTypes := Array 
			with: TypeFLOAT with: TypeDOUBLE with: TypeDECIMAL with: TypeNEWDECIMAL].
	^ realTypes
	
]

{ #category : #Accessing }
MysqlTypes class >> stringTypes [
	stringTypes ifNil: [
		stringTypes := Array with: TypeSTRING with: TypeVARCHAR with: TypeVARSTRING ].
	^ stringTypes
	
]

{ #category : #Accessing }
MysqlTypes class >> typeBIT [
	^ TypeBIT
	
]

{ #category : #Accessing }
MysqlTypes class >> typeBLOB [
	^ TypeBLOB
	
]

{ #category : #Accessing }
MysqlTypes class >> typeDATE [
	^ TypeDATE
	
]

{ #category : #Accessing }
MysqlTypes class >> typeDATETIME [
	^ TypeDATETIME
	
]

{ #category : #Accessing }
MysqlTypes class >> typeDECIMAL [
	^ TypeDECIMAL
	
]

{ #category : #Accessing }
MysqlTypes class >> typeDOUBLE [
	^ TypeDOUBLE
	
]

{ #category : #Accessing }
MysqlTypes class >> typeENUM [
	^ TypeENUM
	
]

{ #category : #Accessing }
MysqlTypes class >> typeFLOAT [
	^ TypeFLOAT
	
]

{ #category : #Accessing }
MysqlTypes class >> typeGEOMETRY [
	^ TypeGEOMETRY
	
]

{ #category : #Accessing }
MysqlTypes class >> typeINT24 [
	^ TypeINT24
	
]

{ #category : #Accessing }
MysqlTypes class >> typeLONG [
	^ TypeLONG
	
]

{ #category : #Accessing }
MysqlTypes class >> typeLONGBLOB [
	^ TypeLONGBLOB
	
]

{ #category : #Accessing }
MysqlTypes class >> typeLONGLONG [
	^ TypeLONGLONG
	
]

{ #category : #Accessing }
MysqlTypes class >> typeMEDIUMBLOB [
	^ TypeMEDIUMBLOB
	
]

{ #category : #Accessing }
MysqlTypes class >> typeNEWDATE [
	^ TypeNEWDATE
	
]

{ #category : #Accessing }
MysqlTypes class >> typeNEWDECIMAL [
	^ TypeNEWDECIMAL
]

{ #category : #Accessing }
MysqlTypes class >> typeNULL [
	^ TypeNULL
	
]

{ #category : #Accessing }
MysqlTypes class >> typeSET [
	^ TypeSET
	
]

{ #category : #Accessing }
MysqlTypes class >> typeSHORT [
	^ TypeSHORT
	
]

{ #category : #Accessing }
MysqlTypes class >> typeSTRING [
	^ TypeSTRING
	
]

{ #category : #Accessing }
MysqlTypes class >> typeTIME [
	^ TypeTIME
	
]

{ #category : #Accessing }
MysqlTypes class >> typeTINY [
	^ TypeTINY
	
]

{ #category : #Accessing }
MysqlTypes class >> typeTINYBLOB [
	^ TypeTINYBLOB
	
]

{ #category : #Accessing }
MysqlTypes class >> typeVARCHAR [
	^ TypeVARCHAR
	
]

{ #category : #Accessing }
MysqlTypes class >> typeVARSTRING [
	^ TypeVARSTRING
	
]

{ #category : #Accessing }
MysqlTypes class >> typeYEAR [
	^ TypeYEAR
	
]
