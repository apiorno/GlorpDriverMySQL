transactions
rollbackTransaction
	isInTransaction := false.
	[super rollbackTransaction] ensure:[self releaseConnection]. 
	self log: 'DBXPoolingDriver - has rolled back  a transaction'