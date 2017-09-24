connection-pooling
releaseConnection

	connection ifNil:[
		self error: 'DBXPoolingDriver - ERROR Releasing the connection, but its already nil ERROR'.
		^ self.
	].

	connection ifNotNil:[
		self isInTransaction ifTrue:[
			self error: 'DBXPoolingDriver -- Returning a connection that has an open Transaction '.
			^ self
			"self commitTransaction"
		].
		
		"Connection cleanUp."
		self connectionPool addConnection: connection.
		self log: 'DBXPoolingDriver - Connection is returned  to pool and setting current pointer to nil '.
		connection := nil
	]