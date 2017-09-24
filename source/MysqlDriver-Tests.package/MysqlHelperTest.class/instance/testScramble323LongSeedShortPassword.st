as yet unclassified
testScramble323LongSeedShortPassword
	self assert: '5a4d46474353585f' asUppercase = 
		(MysqlHelper hexStringFromBytes: ( 
			MysqlHelper scramble323: '8bytesofstuff' with: 'root' )).
			