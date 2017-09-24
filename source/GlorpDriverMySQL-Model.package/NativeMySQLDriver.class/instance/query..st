private
query: aString
	| result |
	result := connection query: aString.
	result isError
		ifTrue: [ self error: result message ].
	^result