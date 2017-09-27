Tests
testNullBitMap
	| params cmd |
	params := (1 to: 30)
		collect: [ :each | MysqlBindParam new bindValue: nil ].
	cmd := MysqlComExecute new.
	cmd params: params.
	self assert: 4 equals: cmd nullBitMap size.
	self
		assert:
			(ByteArray
				with: 16rFF
				with: 16rFF
				with: 16rFF
				with: 16r3F)
		equals: cmd nullBitMap