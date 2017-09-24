as yet unclassified
fixtureReals
	^ #(
	'insert into 
		testReals (floatValue, doubleValue, realValue, decimalValue, numericValue)
	values 
		(1.1, 11.11, 222.222, 3333.333333, 4444.444444), 
		(null, null, null, null, -5555.555555),
		(-1.1, -11.11, -222.222, -3333.333333, -4444.444444)' 
	)