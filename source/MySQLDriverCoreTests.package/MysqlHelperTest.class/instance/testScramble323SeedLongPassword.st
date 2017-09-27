Tests
testScramble323SeedLongPassword
	self
		assert: '5554585a434c5459' asUppercase
		equals:
			(MysqlHelper
				hexStringFromBytes: (MysqlHelper scramble323: 'somedata' with: 'stdbtestpass'))