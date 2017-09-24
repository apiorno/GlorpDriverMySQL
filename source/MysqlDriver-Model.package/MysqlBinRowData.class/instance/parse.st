as yet unclassified
parse
	| col |
	header := inStream next.	"always 0"
	nullBitMap := inStream next: (columnDescriptors size + 9) // 8.
	columnValues := Array new: columnDescriptors size.
	columnDescriptors doWithIndex: 
		[ :colDescr :indx | 
		col := (self isColumnNullAt: indx) 
			ifTrue: [ nil ]
			ifFalse: 
				[ self 
					readColumnFrom: inStream
					perDescrption: colDescr ].	"null"	"non-null; read from stream per col description"
		columnValues 
			at: indx
			put: col ]