Tests
testParamNull
	| inParam |
	inParam := MysqlBindParam new.

	inParam bindValue: nil.
	self assert: inParam isNull.
