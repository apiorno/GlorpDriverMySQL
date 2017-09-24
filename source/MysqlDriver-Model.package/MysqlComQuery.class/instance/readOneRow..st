as yet unclassified
readOneRow: fieldCount
	| row |
	row := MysqlQueryRowData new.
	row columnCount: fieldCount.
	row read: session read.
	^ row
	