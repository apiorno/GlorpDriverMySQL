as yet unclassified
driverSpecNoDb
	^ MysqlDriverSpec new
		host: 'localhost';
		port: 3306;
		user: 'sodbxtest';
		password: 'sodbxtest';
		yourself