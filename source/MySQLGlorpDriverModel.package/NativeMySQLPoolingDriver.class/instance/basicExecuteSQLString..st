Connection-Pooling
basicExecuteSQLString: aString
	^ self withConnectionDo: [ super basicExecuteSQLString: aString]