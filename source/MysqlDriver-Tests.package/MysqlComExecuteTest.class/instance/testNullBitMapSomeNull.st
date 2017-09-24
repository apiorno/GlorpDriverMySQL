as yet unclassified
testNullBitMapSomeNull
	| params cmd |

	params := (1 to: 32) collect: [:each | MysqlBindParam new bindValue: #foo].
	params at: 8 put: (MysqlBindParam new bindValue: nil).
	params at: 16 put: (MysqlBindParam new bindValue: nil).
	params at: 24 put: (MysqlBindParam new bindValue: nil).
	params at: 32 put: (MysqlBindParam new bindValue: nil).
	
	cmd := MysqlComExecute new.
	cmd params: params.
	self assert: (4 = cmd nullBitMap size).
	self 
		assert: (ByteArray with: 16r80 with: 16r80 with: 16r80 with: 16r80) = cmd nullBitMap.
