testing
isLongData
	| typeRange |
	"We also send varchar types as long data"
	self paramType = MysqlTypes typeVARCHAR ifTrue: [^ true].
	typeRange := (MysqlTypes typeTINYBLOB to: MysqlTypes typeSTRING).
	^ typeRange includes: self paramType 
	