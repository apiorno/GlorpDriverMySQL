as yet unclassified
testReadTimeWithDaysOnly
	| strm reader |

	strm := ReadWriteStream on: ByteArray new.
	strm nextPutAll: #(16r05 16r00 16r11 16r22 16r33 16r44). " implies duration of 1144201745"
	strm reset.
	
	reader := MysqlBinReader default.
	self 
		assert: (reader timeFrom: strm) 
			= (Duration fromString: '1144201745;00:00:00:00')
		description: 'should be a Duration when only <days> field present'.
		