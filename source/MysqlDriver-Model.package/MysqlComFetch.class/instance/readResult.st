as yet unclassified
readResult
	| pkt fieldsEof rows fields rowsEof |
	pkt := MysqlPacket from: session peek.
	pkt isError ifTrue: [^ MysqlError from: session read].
	
	"If not error then zero or more row data packets followed by eof packet"
	fields := resultSetContext fields.
	fieldsEof := resultSetContext fieldsEof.
	fieldsEof hasOpenCursor ifTrue: [	
		rows := self readRowData: fields.
		rowsEof := self readEof. "eof"].
	
	^ resultSetContext
		rows: rows asOrderedCollection;
		rowsEof: rowsEof;
		yourself
		