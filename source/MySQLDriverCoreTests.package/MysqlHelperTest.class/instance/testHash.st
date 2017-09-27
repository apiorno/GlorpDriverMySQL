Tests
testHash
	self 
		assert: #(1345345333 305419889 ) = (MysqlHelper hash: '')
		description: 'Hash on empty string'.
	self 
		assert: #(1563302201 1019604839 ) = (MysqlHelper hash: 'password')
		description: 'Hash on string ''password'''.
	self 
		assert: #(1274050763 633181955 ) = (MysqlHelper hash: 'Smalltalk')
		description: 'Hash on ''Smalltalk'''.
	self 
		should: [ MysqlHelper hash: nil ]
		raise: Exception
		description: 'Hash on nil should throw exception'