Reading
readPrepareOkay
	| prepOkay params columns paramEof columnEof indx |
	
	prepOkay := MysqlPrepareOkay from: session read.
	params := Array new: prepOkay numParams.
	columns := Array new: prepOkay numColumns.
	
	prepOkay numParams > 0 ifTrue: [
		indx := 1.	
		[self gotEof] whileFalse: [
			params at: indx put: self readParamDescr.
			indx := indx + 1 ].
		paramEof := self readEof "eof"].

	prepOkay numColumns > 0 ifTrue: [	
		indx := 1.
		[self gotEof ] whileFalse: [
			columns at: indx put: self readColumnDescr.
			indx := indx + 1 ].
		columnEof := self readEof "eof"].
		
	^ MysqlPrepareResp new
		prepareOkay: prepOkay;
		paramDescriptors: params;
		paramEof: paramEof;
		columnDescriptors: columns;
		columnEof: columnEof;
		yourself
	