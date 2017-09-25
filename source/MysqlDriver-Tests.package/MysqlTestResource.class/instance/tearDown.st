Finalization
tearDown
	self disconnecTestConnection.	
	self deleteTestDb.
	self deleteAlternativeUser.
	self disconnectFromServer.
