Connection
disconnecTestConnection
	testConn ifNotNil:[
		[testConn disconnect] on: MysqlNoConnectionError do: [:ex |ex resume]]
