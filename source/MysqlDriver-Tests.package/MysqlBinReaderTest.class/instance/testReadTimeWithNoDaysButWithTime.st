Tests
testReadTimeWithNoDaysButWithTime
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(16r08 16r00 16r00 16r00 16r00 16r00 16r0A 16r0B 16r0C). 
		" implies time of 10:11:12"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader timeFrom: strm) 
			= (Time fromString: '10:11:12')
		description: 'should be a Time when <days> is zero'.
		