as yet unclassified
commandArg
	| buffStream |
	buffStream := WriteStream on: ByteArray new.
	buffStream
		nextPutAll: user asByteArray;
		nextPut: 0.
	MysqlPacket new 
		encodeLcs: scrambledPassword asByteArray
		on: buffStream.
	buffStream
		nextPutAll: (database 
				ifNil: [ '' asByteArray ]
				ifNotNil: [ database asByteArray ]);
		nextPut: 0.
	buffStream
		nextPut: (charset digitAt: 1);
		nextPut: (charset digitAt: 2).
	^ buffStream contents