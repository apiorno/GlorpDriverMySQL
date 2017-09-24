as yet unclassified
testReadDateTimeWithDateFieldsOnly
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(4 219 7 5 31). "2011-05-31"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader dateTimeFrom: strm) = 
				(DateAndTime
					localTimeZone: TimeZone default;
					fromString: '2011-05-31T00:00:00.000000000')
		description: 'should be a DateTime reading only date fields when <length> eq 4 bytes'.
		