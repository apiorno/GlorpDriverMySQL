Tests
testReadTimeWithZeroDaysOnly
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(16r05 16r00 16r00 16r00 16r00 16r00). " implies duration of 1144201745"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader timeFrom: strm) 
			= (Duration fromString: '00:00:00:00')
		description: 'should be a zero hour Time when only <days> field present and is zero'.
		