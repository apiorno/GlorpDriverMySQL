Class {
	#name : #MysqlStmtParamTest,
	#superclass : #TestCase,
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #Tests }
MysqlStmtParamTest >> testParamNull [
	| inParam |
	inParam := MysqlBindParam new.

	inParam bindValue: nil.
	self assert: inParam isNull.

]
