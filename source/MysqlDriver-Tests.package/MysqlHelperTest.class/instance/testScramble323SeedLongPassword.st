as yet unclassified
testScramble323SeedLongPassword
	self assert: '5554585a434c5459' asUppercase = 
		(MysqlHelper hexStringFromBytes: ( 
			MysqlHelper scramble323: 'somedata' with: 'stdbtestpass' )).
			