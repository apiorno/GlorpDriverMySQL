Actions
clearTestTables
	#(
	'nameValue' 'warn' 'mix' 'testMisc' 'testIntegers' 'testReals' 'testTimes' 'testChars'
	'testBinaries' 'testBlobs' 'testTexts') 
		do: [:each | conn query: 'truncate table ', each]
