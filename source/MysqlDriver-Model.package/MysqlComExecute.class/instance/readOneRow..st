as yet unclassified
readOneRow: fields 
	| row |
	row := mapResultsToNativeTypes 
		ifTrue: [ MysqlBinRowData new ]
		ifFalse: [ MysqlStringRowData new ].
	row columnDescriptors: fields.
	row read: session read.
	^ row