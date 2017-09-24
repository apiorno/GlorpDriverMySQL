as yet unclassified
testConnectBad
	| connSpec |
	connSpec := self badConnectionSpec .
	self assert: (connector connect: connSpec) isError .
	