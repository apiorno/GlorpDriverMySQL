as yet unclassified
testMaxLength
	self assert: (MysqlNetPacket maxLength = 16rFFFFFF).
	self assert: (MysqlNetPacket new maxLength = 16rFFFFFF)