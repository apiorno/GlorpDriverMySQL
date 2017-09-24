api
addConnection: aConnection 
	(aConnection notNil and: [aConnection isConnected])
	ifTrue: [
		self queue nextPut: aConnection
	]
	ifFalse:[
		self error: 'Attempting to add an invalid or closed connection to the pool'
	]