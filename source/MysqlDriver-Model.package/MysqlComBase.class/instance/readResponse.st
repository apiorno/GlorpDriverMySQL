as yet unclassified
readResponse
	| resp |

	resp := MysqlPacket from: session peek.
	resp isError ifTrue: [^ MysqlError from: session read].
	resp isOkay ifTrue: [^ MysqlOkay from: session read].

	^ resp "Response type unknown at this point"