Connection
disconnectFromServer
	[conn disconnect] on: MysqlNoConnectionError do: [:ex |ex resume].
