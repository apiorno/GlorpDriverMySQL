Transactions
beginTransaction
	isInTransaction := true.
	connection ifNil:[
		connection:=self acquireConnection
	].
	super beginTransaction.	
	self log: 'DBXPoolingDriver - has started a transaction'

