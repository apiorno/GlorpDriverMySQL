as yet unclassified
testReadTimeWithNoDaysButWithTimeAndSubseconds
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(16r0C 16r00 16r00 16r00 16r00 16r00 16r0A 16r0B 16r0C
		16r04 16r03 16r02 16r00). 
		" implies time of 10:11:12.131844000"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader timeFrom: strm) 
			= (Time hour: 10 minute:11 second:12 nanoSecond:131844000)
		description: 'should be a Time with subseconds if given when <days> is zero'.
		