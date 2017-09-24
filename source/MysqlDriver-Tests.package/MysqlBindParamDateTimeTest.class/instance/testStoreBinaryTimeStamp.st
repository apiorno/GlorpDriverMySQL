as yet unclassified
testStoreBinaryTimeStamp
	theParam bindValue: (TimeStamp epoch). "Squeak epoch: 1901-01-01"
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '046D070101'.

	theParam bindValue: (TimeStamp year: 2011 month: 06 day: 21
							hour: 16 minute:45 second:30).
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '07DB070615102D1E'.
	
	theParam bindValue: (TimeStamp year: 2011 month: 06 day: 21
							hour: 16 minute:45 second:30 nanoSecond: 123456 offset: 0 asDuration).
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '0BDB070615102D1E7B000000'.
	