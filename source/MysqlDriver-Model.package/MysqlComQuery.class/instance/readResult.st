as yet unclassified
readResult
	| fields fieldsEof rows rowsEof resultSetHdr pkt |
	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [ ^ pkt ]
		ifFalse: [ resultSetHdr := self readRsHeader ].
	fields := self readFields.
	fieldsEof := self readEof.
	rows := self readRowData: resultSetHdr fieldCount.
	rowsEof := self readEof.
	^ MysqlResultSet new
		header: resultSetHdr;
		fields: fields;
		fieldsEof: fieldsEof;
		rows: rows;
		rowsEof: rowsEof;
		yourself