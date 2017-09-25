Tests
testNullParamBinaryWrite
	"binding a nil param
		- should produce an empty string in binary protocol"
	ByteArray streamContents: [:strm |
		theParam storeBinaryOn: strm.
		self 
			should: [strm contents isEmpty]
			description: 'binding nil should produce an empty string in binary protocol']
		