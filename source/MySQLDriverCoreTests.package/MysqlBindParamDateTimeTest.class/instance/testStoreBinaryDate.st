Tests
testStoreBinaryDate
	theParam bindValue: (Date fromString: '06-21-2011').
	self
		assert: (MysqlHelper hexStringFromBytes: self storeBinary)
		equals: '04DB070615'