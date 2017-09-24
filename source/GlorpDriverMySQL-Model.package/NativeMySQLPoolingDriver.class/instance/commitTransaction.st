transactions
commitTransaction
	isInTransaction := false.
	[super commitTransaction] ensure:[self releaseConnection].
	self log: 'DBXPoolingDriver - has committed a transaction $'
