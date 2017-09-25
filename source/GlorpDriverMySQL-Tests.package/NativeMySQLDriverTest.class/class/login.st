private protocol
login
	^Login new
		database: self platform new;
		username: 'root';
		password: '';
		connectString: 'localhost_sodbxtest'