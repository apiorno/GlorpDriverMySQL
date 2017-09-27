Connection
connectToServer
	| resp |
	conn := MysqlDriver new.
	resp := conn connect: self class driverSpecNoDb.
	resp isOkay 
		ifFalse: [ ^ self error: 'Failed to connect to MySQL server' ]