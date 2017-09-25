Tests
testStoreBinaryDateAndTime
	theParam bindValue: (DateAndTime epoch). "Squeak epoch: 1901-01-01"
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '046D070101'.

	theParam bindValue: (DateAndTime fromString: '2011-06-21T16:45:30.00000000').
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '07DB070615102D1E'.
	
	theParam bindValue: (DateAndTime fromString: '2011-06-21T16:45:30.00123456').
	"Since the microseconds are stored form the nano (1234 from 1234560 ns)"
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '0BDB070615102D1ED2040000'.
	