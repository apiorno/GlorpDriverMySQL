accessing
changeUser: connSpec 
	| com scrmbl |
	self assertConnection.
	com := MysqlComChangeUser onSession: netSession.
	scrmbl := connSpec password isEmptyOrNil 
		ifTrue: [ '' asByteArray ]
		ifFalse: [ 
			MysqlHelper 
				secureScramble: 
					handshakeInfo scrambleBuff , handshakeInfo scrambleBuffMore
				with: connSpec password ].
	com
		user: connSpec user;
		scrambledPassword: scrmbl;
		database: connSpec db;
		password: connSpec password;
		scrambleBuff: handshakeInfo scrambleBuff;
		charset: handshakeInfo serverLang.
	^ com execute