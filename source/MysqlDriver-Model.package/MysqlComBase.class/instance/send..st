Writing
send: cmd
	| buffer |

	buffer := cmd write.
	session write: buffer.
