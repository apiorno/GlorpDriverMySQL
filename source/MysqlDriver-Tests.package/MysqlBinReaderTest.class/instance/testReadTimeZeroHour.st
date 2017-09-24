as yet unclassified
testReadTimeZeroHour
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(0). " implies 00:00:00"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader timeFrom: strm) 
			= (Time fromString: '00:00:00')
		description: 'should be a zero-hour Time when length is zero'.
		