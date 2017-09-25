Connection-Pooling
withConnectionDo: aBlock
	connection isNil
		ifTrue: [ connection := self acquireConnection ].

	"If we are in a transaction, then we should not release the connection here, rather wait for the commit or rollback to release it"
	isInTransaction
		ifTrue: [ ^ aBlock value ].
	^ [ aBlock value ]
		ensure: [ self releaseConnection ]