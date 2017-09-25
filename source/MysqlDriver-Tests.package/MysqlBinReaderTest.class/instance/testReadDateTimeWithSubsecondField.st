Tests
testReadDateTimeWithSubsecondField
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(11 219 7 5 31 14 30 45 255 1 0 0). "2011-05-31, 14:30:45, 511 us"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader dateTimeFrom: strm) 
			= (DateAndTime 
				localTimeZone: TimeZone default;
				fromString: '2011-05-31T14:30:45.000511000')
		description: 'should be a DateTime reading all fields when <length> eq 11 bytes'.
		