Test Support
goodConnectionSpec
	^ MysqlDriverSpec new
		host: 'localhost';
		port: 3306;
		user: 'root';
		password: '';
		yourself