Tests
testByteNonBoundariesAtEnd
	row nullBitMap: #(16r78 16r7E 16r7E 16r7E).
	self deny: (row isColumnNullAt: 23) description: 'Column 23 should not be null'.
	self assert: (row isColumnNullAt: 24) description: 'Column 24 should be null'.
	self assert: (row isColumnNullAt: 25) description: 'Column 25 should be null'.
	self assert: (row isColumnNullAt: 26) description: 'Column 26 should be null'.
	self assert: (row isColumnNullAt: 27) description: 'Column 27 should be null'.
	self assert: (row isColumnNullAt: 28) description: 'Column 28 should be null'.
	self assert: (row isColumnNullAt: 29) description: 'Column 29 should be null'.
	self deny: (row isColumnNullAt: 30) description: 'Column 30 should not be null'.
	