Accessing
ping
	self assertConnection.
	^ (MysqlComPing onSession: netSession) execute