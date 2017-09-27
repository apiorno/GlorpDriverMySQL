Tests
testAcceptLongParams
	| prep stmtId resp params stmt |
	"
	NOTE: This is guided by the settings of mx_allowed_packet value. Default is 1 MB.
	You can check it with 'select @@max_allowed packet' command or cahange it by
	issuing 'set global max_allowed_packet = <another value>'. We test the long params
	within the default bounds.
	"
	prep := self connection
		prepare:
			'insert into 
			testBlobs (tinyblobValue, blobValue, mediumblobValue, longBlobValue) 
			values (NULL, NULL, NULL, ?)'.
	stmtId := prep prepareOkay stmtHandlerId.
	params := MysqlBindParam
		listOfSize: prep prepareOkay numParams
		forDescriptors: prep paramDescriptors.
	"try a blob just less than default max_allowed_packet, which is 1M"
	params first bindValue: (ByteArray new: 1023 * 1024 withAll: 16r55).
	stmt := MysqlDriverStmt onConnection: self connection.
	stmt
		stmtId: stmtId;
		params: params.
	resp := stmt execute.
	self assert: resp isOkay.
	self assert: resp affectedRows equals: 1