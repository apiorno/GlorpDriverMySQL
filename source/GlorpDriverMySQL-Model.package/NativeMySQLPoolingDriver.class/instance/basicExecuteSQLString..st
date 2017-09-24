connection-pooling
basicExecuteSQLString: aString
	^ self withConnectionDo: [ super basicExecuteSQLString: aString]