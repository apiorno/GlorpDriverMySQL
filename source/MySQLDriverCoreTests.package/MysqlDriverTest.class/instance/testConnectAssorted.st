Tests
testConnectAssorted
	| connSpec |
	
	connSpec := self goodConnectionSpec .
	self assert: (connector connect: connSpec) isOkay.
	connector disconnect.
	
	connSpec := self badConnectionSpec .
	self assert: (connector connect: connSpec) isError.
	connector connected ifTrue: [connector disconnect].

	connSpec := self goodConnectionSpec .
	self assert: (connector connect: connSpec) isOkay .
	connector disconnect.
