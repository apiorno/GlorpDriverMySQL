as yet unclassified
testMyRandom
	MysqlHelper randomInitWith: 3252345 and: 7149734.
	self assert: (MysqlHelper myRandom closeTo: 0.0157456556481734).
	self assert: (MysqlHelper myRandom closeTo: 0.0696413620092360).
	self assert: (MysqlHelper myRandom closeTo: 0.3009698738353047).
	self assert: (MysqlHelper myRandom closeTo: 0.2959253138824602).
	self assert: (MysqlHelper myRandom closeTo: 0.5767169786400320).
	self assert: (MysqlHelper myRandom closeTo: 0.9958089822864243).
	self assert: (MysqlHelper myRandom closeTo: 0.2488940062456708).
	self assert: (MysqlHelper myRandom closeTo: 0.2570431151027261).
	self assert: (MysqlHelper myRandom closeTo: 0.5385335875102631).
	self assert: (MysqlHelper myRandom closeTo: 0.9215386229767824)
	
	
	