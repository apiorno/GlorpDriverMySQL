as yet unclassified
badConnectionSpec
	| connSpec |
	
	connSpec := self goodConnectionSpec .
	connSpec password: 'wrongpassword' .
	
	^ connSpec