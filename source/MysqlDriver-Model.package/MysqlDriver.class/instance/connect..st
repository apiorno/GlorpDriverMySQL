Accessing
connect: connSpec 
	| handshake resp |
	
	self connected ifTrue: [^ MysqlDriverError signal: 'Driver is already connected'].
	netSession ifNil: [netSession := MysqlNetSession new].
	netSession toHost: connSpec host andPort: connSpec port.

	handshake := self readHandshake.
	self writeAuthForHandshake: handshake onConnection: connSpec.

	resp := self peekResponse.
	resp isEof ifTrue: [
		"Read the send short hash indicator: ainsgle eof(254) byte)"
		self readResponse.
		"This is an indication that comes from server if the password for this user
		follows the old style (short hash) instead of the new style (long hash). 
		We need to send back the 323 scramble"
		self send323Scramble: handshake scrambleBuff password: connSpec password.
		resp := self peekResponse]. 
	resp isError ifTrue: [^ MysqlError from: netSession read].
	resp isOkay ifTrue: [
		self keepHandshakeInfo: handshake.
		^ MysqlOkay from: netSession read].
	
	MysqlDriverError signal: 'Unexpected response from server: data is not okay/error/eof'
	