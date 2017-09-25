Tests
testScramble323LongSeedLongPassword
	self assert: '4d545b475f524d45' asUppercase = 
		(MysqlHelper hexStringFromBytes: ( 
			MysqlHelper scramble323: 'e8cf00cec9ec825af22' with: 'saf789yasfbsd')).
			