Tests
testReadDateIgnoeTimeFields
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(11 219 7 5 31 14 30 45 1 2 3 4). "2011-05-31, 14:30:45, micros"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader dateFrom: strm) = (Date fromString: 'May 31 2011')
		description: 'should be a Date ignoring fields other than year, month, day'.
		