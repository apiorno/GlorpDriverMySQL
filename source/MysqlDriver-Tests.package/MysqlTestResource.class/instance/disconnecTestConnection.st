as yet unclassified
disconnecTestConnection
	testConn ifNotNil:[
		[testConn disconnect] on: MysqlNoConnectionError do: [:ex |]]
