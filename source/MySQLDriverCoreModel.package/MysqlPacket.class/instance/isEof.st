Testing
isEof
	^ (discriminator = 16rFE) and: [inStream size < 9]
