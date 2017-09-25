Accessing
disconnect
	self assertConnection.
	(MysqlComQuit  onSession: netSession) execute.
	netSession disconnect.
	