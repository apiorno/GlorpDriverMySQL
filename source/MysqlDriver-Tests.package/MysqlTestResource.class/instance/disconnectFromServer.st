as yet unclassified
disconnectFromServer
	[conn disconnect] on: MysqlNoConnectionError do: [:ex |].
