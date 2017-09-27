Tests
testNullBitMapMajorityNull
	| params cmd |
	params := (1 to: 32)
		collect: [ :each | MysqlBindParam new bindValue: nil ].
	params at: 8 put: (MysqlBindParam new bindValue: #foo).
	params at: 16 put: (MysqlBindParam new bindValue: #foo).
	params at: 24 put: (MysqlBindParam new bindValue: #foo).
	params at: 32 put: (MysqlBindParam new bindValue: #foo).
	cmd := MysqlComExecute new.
	cmd params: params.
	self assert: 4 equals: cmd nullBitMap size.
	self
		assert:
			(ByteArray
				with: 16r7F
				with: 16r7F
				with: 16r7F
				with: 16r7F)
		equals: cmd nullBitMap