Login
logout
	self log: 'DBXPoolingDriver - logging out'.
	self connectionPool reset
	
