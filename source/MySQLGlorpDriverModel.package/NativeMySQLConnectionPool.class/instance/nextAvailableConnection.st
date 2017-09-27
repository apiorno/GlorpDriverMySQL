Connection-Pooling
nextAvailableConnection
	| connection |
	
	"Remove any stale connections in this pool"
	self cleanPool.

	[self queue isEmpty]
		whileFalse: [connection := self queue nextOrNil.
			(connection notNil and: [ connection isConnected ])
				ifTrue: [
					^ connection
			]
		].
	^ nil
