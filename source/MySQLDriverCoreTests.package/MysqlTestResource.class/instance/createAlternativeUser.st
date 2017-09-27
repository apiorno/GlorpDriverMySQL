Actions
createAlternativeUser
	"Creates an aalternative user with the same password as the main test user"
	| resp |
	resp := conn query: 'CREATE USER ''', self class alternativeUsername , '''@''%''IDENTIFIED BY ''', self class driverSpecNoDb password , ''';'.
	resp isOkay ifFalse: [^ self error: 'Can not create second user'].