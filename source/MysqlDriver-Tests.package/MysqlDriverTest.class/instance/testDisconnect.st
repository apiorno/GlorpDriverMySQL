as yet unclassified
testDisconnect

	| connSpec |
	
	connSpec := self goodConnectionSpec .
	self assert: (connector connect: connSpec) isOkay.
	self shouldnt: [connector disconnect] raise: MysqlNoConnectionError .
	self should: [connector disconnect] raise: MysqlNoConnectionError .