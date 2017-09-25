Tests
testHostLookupError
	| connSpec |
	connSpec := self invalidHostNameConnectionSpec.
	self should: [connector connect: connSpec] raise: MysqlNameLookupFailure.
