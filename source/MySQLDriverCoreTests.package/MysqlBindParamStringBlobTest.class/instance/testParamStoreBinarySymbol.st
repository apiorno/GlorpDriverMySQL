Tests
testParamStoreBinarySymbol
	theParam bindValue: #hello.
	"lengthcoded + string bytes"
	self assert: (self storeBinary hasEqualElements: 
		(ByteArray with: 5), 'hello' asByteArray).
