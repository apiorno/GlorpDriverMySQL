Accessing
testConnection
	"Returns a connection to be used for the testXyz methods. 
	Not to be confused with the internal connection instance 
	for setting up schemas and tables"
	(testConn isNil or: [ testConn connected not ]) 
		ifTrue: [
			testConn := MysqlDriver new.
			testConn connect: self class driverSpecWithDb].
	^ testConn