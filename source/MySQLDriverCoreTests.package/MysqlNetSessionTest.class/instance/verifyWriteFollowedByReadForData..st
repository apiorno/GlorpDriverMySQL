Asserting
verifyWriteFollowedByReadForData: writeData
	| readData |
	session write: writeData.
	ioStream reset.
	session resetSequence.
	readData := session readPacketData.
	self assert: readData size equals: writeData size.
	self assert: (readData hasEqualElements: writeData)