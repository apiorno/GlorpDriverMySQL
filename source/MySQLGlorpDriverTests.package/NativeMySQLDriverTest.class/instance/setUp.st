Initialization
setUp
	connection := self class nativeDriver new .
	connection connect: self class login .