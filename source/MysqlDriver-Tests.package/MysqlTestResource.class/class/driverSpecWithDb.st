Accessing
driverSpecWithDb
	^ self driverSpecNoDb
		db: self dbName;
		yourself
		