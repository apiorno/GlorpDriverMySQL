Tests
testNullBitMapAllButFirstAndLastNull
	| params cmd |
	params := Array new: 32.
	params at: 1 put: (MysqlBindParam new bindValue: 'foo').
	2 to: 31 do: [ :indx | params at: indx put: (MysqlBindParam new bindValue: nil) ].
	params at: 32 put: (MysqlBindParam new bindValue: 'bar').
	cmd := MysqlComExecute new.
	cmd params: params.
	self assert: 4 equals: cmd nullBitMap size.
	self
		assert:
			(ByteArray
				with: 16rFE
				with: 16rFF
				with: 16rFF
				with: 16r7F)
		equals: cmd nullBitMap