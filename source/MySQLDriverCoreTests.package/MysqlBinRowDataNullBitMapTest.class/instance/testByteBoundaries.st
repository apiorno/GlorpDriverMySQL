Tests
testByteBoundaries
	row nullBitMap: #(16r84 16r81 16r81 16r81).
	self assert: (row isColumnNullAt: 1) description: 'Column 1 should be null'.
	self assert: (row isColumnNullAt: 6) description: 'Column 6 should be null'.
	self assert: (row isColumnNullAt: 7) description: 'Column 7 should be null'.
	self assert: (row isColumnNullAt: 14) description: 'Column 14 should be null'.
	self assert: (row isColumnNullAt: 15) description: 'Column 15 should be null'.
	self assert: (row isColumnNullAt: 22) description: 'Column 22 should be null'.
	self assert: (row isColumnNullAt: 23) description: 'Column 23 should be null'.
	self assert: (row isColumnNullAt: 30) description: 'Column 30 should be null'.
	