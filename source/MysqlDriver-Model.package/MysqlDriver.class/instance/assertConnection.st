testing
assertConnection
	self connected ifFalse: [^ MysqlNoConnectionError signal: 'Driver is not connected'].
	
