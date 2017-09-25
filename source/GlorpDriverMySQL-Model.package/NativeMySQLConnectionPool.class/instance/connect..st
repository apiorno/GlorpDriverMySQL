Connection-Pooling
connect: aLogin
	| nativeDriver connection size fillPoolSize|
	
	self loginCredentials: aLogin.

	size := self queue size.
	fillPoolSize := self maxConnections - size.

	1 to: fillPoolSize do:[:n |
		nativeDriver :=  self nativeDriver new. 
		connection := nativeDriver class connectionClass new.
		connection connect: (nativeDriver getDriverSpecFromLogin: aLogin).
		self addConnection: connection.
		self log: 'DBXPoolingDriver - Added one new connection to the Selma Pool. Connection # ',n asString.
	].

      