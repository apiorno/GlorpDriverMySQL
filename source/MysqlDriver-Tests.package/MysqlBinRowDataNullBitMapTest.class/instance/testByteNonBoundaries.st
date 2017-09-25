Tests
testByteNonBoundaries
	row nullBitMap: #(16r78 16r7E 16r7E 16r7E).
	self deny: (row isColumnNullAt: 1) description: 'Column 1 should not be null'.
	self assert: (row isColumnNullAt: 2) description: 'Column 2 should be null'.
	self assert: (row isColumnNullAt: 3) description: 'Column 3 should be null'.
	self assert: (row isColumnNullAt: 4) description: 'Column 4 should be null'.
	self assert: (row isColumnNullAt: 5) description: 'Column 5 should be null'.
	self deny: (row isColumnNullAt: 6) description: 'Column 6 should not be null'.
	