as yet unclassified
setUp
	connection := self class nativeDriver new .
	connection connect: self class login .