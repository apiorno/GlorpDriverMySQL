as yet unclassified
fixtureIntegers
	^ #(
	'insert into 
		testIntegers (tinyintValue, smallIntValue, mediumintValue, intValue, bigintValue)
		values 
		(0, 300, 40000, 100000, 6000000000), (1, 301, 40001, 100001, 6000000001),
		(2, null, null, null, 6000000002), (3, 303, 40003, 100003, null),
		(-101, -301, -40001, -100001, -6000000001)'
	)