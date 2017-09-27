Printing
printOn: aStream
	super printOn: aStream.

	aStream
		nextPutAll: ' loginCredentials: ';
		print: loginCredentials.
	aStream
		nextPutAll: ' isInTransaction: ';
		print: isInTransaction.
	aStream
		nextPutAll: ' logging: ';
		print: logging.
	aStream
		nextPutAll: ' connection: ';
		print: connection.
	"aStream
		nextPutAll: ' maxConnections: ';
		print: maxConnections.
	aStream
		nextPutAll: ' database: ';
		print: database"