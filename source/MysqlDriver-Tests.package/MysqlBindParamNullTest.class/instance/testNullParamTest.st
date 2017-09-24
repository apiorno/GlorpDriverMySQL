as yet unclassified
testNullParamTest
	"binding a nil value
		- should return true when tested for type NULL
	"
	theParam bindValue: nil.
	self 
		should: [theParam isNull] 
		description: 'binding nil should set type to NULL'
		