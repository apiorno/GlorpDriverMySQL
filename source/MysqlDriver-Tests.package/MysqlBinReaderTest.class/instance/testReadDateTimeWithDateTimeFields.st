as yet unclassified
testReadDateTimeWithDateTimeFields
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(7 219 7 5 31 14 30 45). "2011-05-31, 14:30:45"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader dateTimeFrom: strm) 
			= (DateAndTime 
				localTimeZone: TimeZone default;			
				fromString: '2011-05-31T14:30:45.000000000')
		description: 'should be a DateTime reading date & time fields when <length> eq 7 bytes'.
		