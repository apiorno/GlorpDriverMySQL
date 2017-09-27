Tests
testConnectWithDb
	| connSpec resp |
	connSpec := self goodConnectionSpec.
	connSpec db: 'sodbxtest'.
	resp := connector connect: connSpec.
	self assert: resp isOkay.
	connector disconnect.

	connSpec db: 'sodbxtest2'.
	self assert: (connector connect: connSpec) isError.
	connector connected ifTrue: [ connector disconnect].