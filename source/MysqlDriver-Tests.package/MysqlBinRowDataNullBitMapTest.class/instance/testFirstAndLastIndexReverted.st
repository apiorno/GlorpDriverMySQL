as yet unclassified
testFirstAndLastIndexReverted
	row nullBitMap: #(16r00 16r00 16r00 16r80).
	self deny: (row isColumnNullAt: 1) description: 'Column 1 should be null'.
	self assert: (row isColumnNullAt: 30) description: 'Column 30 should not be null'.
	