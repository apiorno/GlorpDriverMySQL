Tests
testParamStoreBinaryText
	theParam bindValue: (Text fromString: 'This is a text').
	"lengthcoded + string bytes"
	self assert: (self storeBinary hasEqualElements: 
		(ByteArray with: 14), 'This is a text' asByteArray).
