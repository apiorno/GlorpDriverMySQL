as yet unclassified
deleteTestDb
	| resp |
	resp := conn query: 'drop database if exists ', self class dbName.
	resp isOkay ifFalse: [^ self error: 'Can not create test database']	