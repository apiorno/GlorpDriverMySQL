Reading
readResponse
	| resp |
	resp := MysqlPacket from: session peek.
	resp isError ifTrue: [^ MysqlError from: session read].
	resp isOkay ifTrue: [^ self readPrepareOkay]
