Tests
testMaxLength
	self assert: MysqlNetPacket maxLength equals: 16rFFFFFF.
	self assert: MysqlNetPacket new maxLength equals: 16rFFFFFF