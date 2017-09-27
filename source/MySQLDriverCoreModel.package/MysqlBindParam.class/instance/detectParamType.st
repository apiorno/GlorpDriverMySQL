accessing
detectParamType
	"Corresponding database type needs to be inferred from the bound value"
	paramValue ifNil: [ ^ MysqlTypes typeNULL ].

	(paramValue isKindOf: Boolean) ifTrue: [ ^ MysqlTypes typeTINY ].

	(paramValue isKindOf: Integer) ifTrue: [
		(self tinyIntRange includes: paramValue) ifTrue: [^ MysqlTypes typeTINY].
		(self smallIntRange includes: paramValue) ifTrue: [^ MysqlTypes typeSHORT].
		(self longIntRange includes: paramValue) ifTrue: [^ MysqlTypes typeLONG].
		(self bigIntRange includes: paramValue) ifTrue: [^ MysqlTypes typeLONGLONG].
		^ MysqlBindError signal: 'Supplied integer does not have a matching database type'].

	(paramValue isKindOf: ScaledDecimal) ifTrue: [ ^ MysqlTypes typeDECIMAL ].
	((paramValue isKindOf: Float) or:  [paramValue isKindOf: Fraction]) 
		ifTrue: [	
			(paramValue asFloat at: 2) = 0 
				ifTrue: [^ MysqlTypes typeFLOAT]
				ifFalse: [^ MysqlTypes typeDOUBLE] ].

	(paramValue isKindOf: Character) ifTrue: [ ^ MysqlTypes typeSTRING ].
	((paramValue isKindOf: String) or: [paramValue isKindOf: Text]) 
		ifTrue: [ ^ MysqlTypes typeVARSTRING ].

	(paramValue isMemberOf: DateAndTime) ifTrue: [ ^ MysqlTypes typeDATETIME ].
	"(paramValue isKindOf: TimeStamp ) ifTrue: [ ^ MysqlTypes typeTIMESTAMP ].-"
	((paramValue isKindOf: Time) or: [paramValue isKindOf: Duration]) 
		ifTrue: [ ^ MysqlTypes typeTIME ].
	(paramValue isKindOf: Date) ifTrue: [ ^ MysqlTypes typeDATE ].

	(paramValue isKindOf: ByteArray) ifTrue: [ 
		paramValue size < 16r100 ifTrue: [ ^ MysqlTypes typeTINYBLOB ].
		paramValue size < 16r10000 ifTrue: [ ^ MysqlTypes typeBLOB ].
		paramValue size < 16r1000000 ifTrue: [ ^ MysqlTypes typeMEDIUMBLOB ].
		^ MysqlTypes typeLONGBLOB ].
	
	^ MysqlBindError signal: 'Unsupported data type for param binding'
	