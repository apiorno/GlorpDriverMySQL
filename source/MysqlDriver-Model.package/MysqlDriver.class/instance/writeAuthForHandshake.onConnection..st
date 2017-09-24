private
writeAuthForHandshake: handshake onConnection: connSpec

	| auth |

	handshake supportsProtocol41 
		ifTrue: [auth := MysqlClientAuth new]
		ifFalse: [MysqlUnsupportedProtocolError signal: 'Server does not support protocol version 41'].
	
	auth
		serverCaps: handshake serverCaps ;
		charset: handshake serverLang ;
		user: connSpec user ;
		password: connSpec password ;
		database: connSpec db ;
		scrambleBuff: handshake scrambleBuff ;
		scrambleBuffMore: handshake scrambleBuffMore .
		
	self writePacket: auth 