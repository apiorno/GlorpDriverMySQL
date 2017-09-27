Test Support
storeBinary
	ByteArray streamContents: [:strm | 
		theParam storeBinaryOn: strm.
		^ strm contents]	
	