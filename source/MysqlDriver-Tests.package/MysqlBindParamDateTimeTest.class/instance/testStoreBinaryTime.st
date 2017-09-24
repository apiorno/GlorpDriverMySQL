as yet unclassified
testStoreBinaryTime
	theParam bindValue: (Time midnight).
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '00'.

	theParam bindValue: (Time fromString: '16:02:30').
	self assert: (MysqlHelper hexStringFromBytes: self storeBinary) = '08000000000010021E'.

	theParam bindValue: (Time hour: 16 minute: 02 second: 30 nanoSecond: 1234000).
	self assert: 
		(MysqlHelper hexStringFromBytes: self storeBinary) = '0C000000000010021ED2040000'.
	