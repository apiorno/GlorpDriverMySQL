Actions
createTestDb
	| resp |
	resp := conn query: 'create database if not exists ', self class dbName, ' DEFAULT CHARACTER SET latin1'.
	resp isOkay ifFalse: [^ self error: 'Can not create test database'].
	
	resp := conn query: 'use ', self class dbName.
	resp isError ifTrue: [^ self error: 'Failed to use test database'].	
