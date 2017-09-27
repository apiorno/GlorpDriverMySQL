Tests
testScramble323LongSeedShortPassword
	self
		assert: '5a4d46474353585f' asUppercase
		equals:
			(MysqlHelper
				hexStringFromBytes: (MysqlHelper scramble323: '8bytesofstuff' with: 'root'))