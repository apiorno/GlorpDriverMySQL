Tests
testReadTimeWithDaysTimeAndSubseconds
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(16r0C 16r00 16r11 16r22 16r33 16r44 16r0A 16r0B 16r0C
		16r04 16r03 16r02 16r00). 
		" implies duration of 1144201745:10:11:12.131844000"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader timeFrom: strm) 
			= (Duration fromString: '1144201745:10:11:12.131844000')
		description: 'should be a Duration with subseconds if given when <days> is non zero'.
		