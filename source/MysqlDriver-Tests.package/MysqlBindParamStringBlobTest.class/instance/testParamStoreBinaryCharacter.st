as yet unclassified
testParamStoreBinaryCharacter
	theParam bindValue: $A.
	"lengthcoded + charcter as string"
	self assert: (self storeBinary hasEqualElements: (ByteArray with: 1 with: 16r41)).
