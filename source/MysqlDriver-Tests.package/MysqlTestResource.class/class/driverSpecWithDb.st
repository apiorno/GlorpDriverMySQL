as yet unclassified
driverSpecWithDb
	^ self driverSpecNoDb
		db: self dbName;
		yourself
		