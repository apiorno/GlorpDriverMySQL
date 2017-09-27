writes
stringOrBlobBytes		
	ByteArray streamContents: [:strm |
		MysqlHelper encodeLcs: self stringOrBlobBytesRaw on: strm.
		^ strm contents]
	