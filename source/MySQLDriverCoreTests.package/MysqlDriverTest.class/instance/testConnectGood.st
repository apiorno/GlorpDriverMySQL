Tests
testConnectGood

	| connSpec resp |
	
	connSpec := self goodConnectionSpec.
	resp := connector connect: connSpec.
	self assert: resp isOkay.
	