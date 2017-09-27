Tests
testReadDateWithDateFieldsOnly
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(4 219 7 5 31). "2011-05-31"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader dateFrom: strm) = (Date fromString: 'May 31 2011')
		description: 'should be a Date with specified year, month, day'.
		