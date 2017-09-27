Reading
readRsHeader
	^ MysqlResultSetHeader from: session read
	