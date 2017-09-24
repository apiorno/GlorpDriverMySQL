testing
connected
	^ netSession isNil not and: [netSession connected]
	