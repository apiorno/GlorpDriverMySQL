Reading
readResponse
	| resp |
	resp := self readResult.
	resp hasMoreResults ifTrue: [resp nextResult: self readResponse].
	^ resp