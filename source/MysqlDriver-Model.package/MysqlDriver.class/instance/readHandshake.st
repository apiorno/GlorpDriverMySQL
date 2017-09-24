private
readHandshake

	| buffer handshake |

	buffer := netSession read.
	handshake := MysqlHandshake from: buffer.

	^handshake 