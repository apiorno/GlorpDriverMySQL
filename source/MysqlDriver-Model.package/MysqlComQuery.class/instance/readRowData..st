Reading
readRowData: fieldCount 
	| respRows row |
	respRows := OrderedCollection new.
	
	[self gotEof] whileFalse: [ 
		"Read each field and save it"
		row := self readOneRow: fieldCount.
		respRows add: row].
		
	^ respRows asArray
	