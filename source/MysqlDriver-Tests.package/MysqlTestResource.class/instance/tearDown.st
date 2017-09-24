as yet unclassified
tearDown
	self disconnecTestConnection.	
	self deleteTestDb.
	self deleteAlternativeUser.
	self disconnectFromServer.
