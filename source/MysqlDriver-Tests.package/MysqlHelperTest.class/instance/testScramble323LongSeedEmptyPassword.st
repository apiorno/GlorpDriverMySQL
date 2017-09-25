Tests
testScramble323LongSeedEmptyPassword
	self assert: '' = 
		(MysqlHelper hexStringFromBytes: ( 
			MysqlHelper scramble323: 'e8cf00cec9ec825af22' with: '')).
			