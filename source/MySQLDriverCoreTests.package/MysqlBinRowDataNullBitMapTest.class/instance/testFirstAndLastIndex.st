Tests
testFirstAndLastIndex
	row nullBitMap: #(16r04 16r00 16r00 16r00).
	self assert: (row isColumnNullAt: 1) description: 'Column 1 should be null'.
	self deny: (row isColumnNullAt: 30) description: 'Column 30 should not be null'.
	