Tests
testNullBitMapAllNull
	| params cmd |
	params := (1 to: 32)
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
				with: 16rFF)
		equals: cmd nullBitMap