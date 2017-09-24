as yet unclassified
testBigSizeReadWrite
	| pktData |
	
	pktData := ByteArray new: self maxLen * 2 + (self maxLen >> 8) withAll: 16rAA.
	self verifyWriteFollowedByReadForData: pktData	