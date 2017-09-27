private
getDriverSpecFromLogin: aLogin

	"connect string looks like  hostname:portNumber_db-name. :portNumber is optional"
	| connectionLine portIndex index dbIndex driverSpecs |
	connectionLine := aLogin connectString.
	portIndex := index := connectionLine indexOf: $:.
	dbIndex := connectionLine indexOf: $_.
	index = 0 ifTrue: [index := dbIndex].
	
	driverSpecs := (Dialect smalltalkAt: #MysqlDriverSpec) new
		host: (connectionLine copyFrom: 1 to: index - 1);
		port: (portIndex = 0 ifTrue: [3306] ifFalse: [(connectionLine copyFrom: portIndex + 1 to: dbIndex - 1) asNumber]);
		user: aLogin username;
		password: aLogin password;
		database: (connectionLine copyFrom: dbIndex + 1 to: connectionLine size) .
		
	^ driverSpecs