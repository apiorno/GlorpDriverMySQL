as yet unclassified
testMaxSizeReadWrite
	| pktData |
	
	pktData := ByteArray new: self maxLen withAll: 16rAA.
	self verifyWriteFollowedByReadForData: pktData	