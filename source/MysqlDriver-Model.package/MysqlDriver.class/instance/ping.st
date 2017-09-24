accessing
ping
	self assertConnection.
	^ (MysqlComPing onSession: netSession) execute