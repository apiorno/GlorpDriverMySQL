Tests
testLessThanMaxSizeReadWrite
	| pktData |
	
	pktData := ByteArray new: self maxLen >> 8 withAll: 16rAA.
	self verifyWriteFollowedByReadForData: pktData	