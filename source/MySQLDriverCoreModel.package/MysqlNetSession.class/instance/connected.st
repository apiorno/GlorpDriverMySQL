Testing
connected
	^ theStream ifNil: [false] ifNotNil: [theStream isConnected] 