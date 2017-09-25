Tests
testReadTimeWithNegSign
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(16r08 16r01 16r00 16r00 16r00 16r00 16r0A 16r0B 16r0C). 
		" implies duration of -1144201745:10:11:12"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader timeFrom: strm) 
			= (Duration fromString: '-0:10:11:12')
		description: 'should be a Duration when <sign> is indicated negative'.
		