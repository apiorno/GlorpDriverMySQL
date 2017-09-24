as yet unclassified
testParamStoreBinaryString
	| value binStrm |
	theParam bindValue: 'hello'.
	"lengthcoded + string bytes"
	self assert: (self storeBinary hasEqualElements: 
		(ByteArray with: 5), 'hello' asByteArray).

	value := ''.
	10 timesRepeat: [value := value, 'abcdefghijklmnopqrstuvwxyz'].
	theParam bindValue: value.
	binStrm := ReadStream on: self storeBinary.
	self assert: (MysqlHelper decodeLcbFrom: binStrm) = 260.
	self assert: (binStrm upToEnd asString hasEqualElements: value)	
	