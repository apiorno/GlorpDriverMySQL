maintenance
reset
	"Removes and closes any connections in the pool"
	|connection|
	[self queue isEmpty]
		whileFalse: [connection := self queue nextOrNil.
			connection notNil 
				ifTrue: [
					connection isConnected ifTrue: [ connection terminate].
					connection := nil.
				]
		].
	queue := nil