as yet unclassified
deleteAlternativeUser
	| resp |
	resp := conn query: 'DROP USER ''', self class alternativeUsername, ''';'.
	resp isOkay ifFalse: [^ self error: 'Can not create second user'].