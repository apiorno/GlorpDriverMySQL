connection-pooling
acquireConnection
	^ self acquireConnectionIfError: [:error | error pass]