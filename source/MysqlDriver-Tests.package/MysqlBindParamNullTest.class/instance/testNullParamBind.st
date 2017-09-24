as yet unclassified
testNullParamBind
	"binding a nil value
		- should set the param type to NULL"
	theParam bindValue: nil.
	self 
		should: [theParam detectParamType = MysqlTypes typeNULL] 
		description: 'binding nil should set param type to NULL'.
		