accessing
storeBinaryOn: aStream		
	paramType 
	caseOf: {
		[MysqlTypes typeNULL]->[].
		[MysqlTypes typeTINY]->[aStream nextPutAll: (self integerBytes: 1)].
		[MysqlTypes typeSHORT]->[aStream nextPutAll: (self integerBytes: 2)].
		[MysqlTypes typeLONG]->[aStream nextPutAll: (self integerBytes: 4)].		
		[MysqlTypes typeLONGLONG]->[aStream nextPutAll: (self integerBytes: 8)].	
		[MysqlTypes typeFLOAT]->[aStream nextPutAll: (self floatBytes)].
		[MysqlTypes typeDOUBLE]->[aStream nextPutAll: (self doubleBytes)].
		[MysqlTypes typeTIME]->[aStream nextPutAll: self timeBytes].
		[MysqlTypes typeDATE]->[aStream nextPutAll: self dateTimeBytes].
		"[MysqlTypes typeTIMESTAMP]->[aStream nextPutAll: self dateTimeBytes]."
		[MysqlTypes typeDATETIME]->[aStream nextPutAll: self dateTimeBytes].	
		[MysqlTypes typeDECIMAL]->[aStream nextPutAll: self decimalBytes]	
	} 
	otherwise: [aStream nextPutAll: self stringOrBlobBytes]
	