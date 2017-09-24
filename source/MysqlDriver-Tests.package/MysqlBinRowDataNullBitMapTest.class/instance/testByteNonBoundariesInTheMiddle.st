as yet unclassified
testByteNonBoundariesInTheMiddle
	row nullBitMap: #(16r78 16r7E 16r7E 16r7E).
	self deny: (row isColumnNullAt: 7) description: 'Column 7 should not be null'.
	self assert: (row isColumnNullAt: 8) description: 'Column 8 should be null'.
	self assert: (row isColumnNullAt: 9) description: 'Column 9 should be null'.
	self assert: (row isColumnNullAt: 10) description: 'Column 10 should be null'.
	self assert: (row isColumnNullAt: 11) description: 'Column 11 should be null'.
	self assert: (row isColumnNullAt: 12) description: 'Column 12 should be null'.
	self assert: (row isColumnNullAt: 13) description: 'Column 13 should be null'.
	self deny: (row isColumnNullAt: 14) description: 'Column 14 should not be null'.
	