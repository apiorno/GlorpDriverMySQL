connection-pooling
acquireConnectionIfError: errorBlock
	(connection notNil and: [ connection isConnected]) ifTrue: [ ^ connection ].
	^ self connectionPool acquireConnectionIfError: errorBlock.