as yet unclassified
parse
	|indx value |

	indx := 1.
	[inStream atEnd] whileFalse: [
		value := (self decodeLcsFrom: inStream) asString.
		columns at: indx put: value.
		indx := indx + 1].
	