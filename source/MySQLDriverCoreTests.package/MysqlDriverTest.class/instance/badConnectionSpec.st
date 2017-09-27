Test Support
badConnectionSpec
	| connSpec |
	
	connSpec := self goodConnectionSpec .
	connSpec password: 'wrongpassword' .
	
	^ connSpec