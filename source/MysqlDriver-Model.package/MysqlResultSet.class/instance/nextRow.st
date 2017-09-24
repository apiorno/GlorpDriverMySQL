cursor
nextRow
		
	(self rows isEmptyOrNil and: [self hasOpenCursor and: [self hasLastRowSent not]])
			ifTrue: [ statement fetchRows: statement fetchSize ].
			
	^ rows ifEmpty: [ nil ] ifNotEmpty: [ rows removeFirst ]