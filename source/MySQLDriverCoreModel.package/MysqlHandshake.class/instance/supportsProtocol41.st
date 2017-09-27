Testing
supportsProtocol41
	^ (serverCap bitAnd: CapProtocol41) = CapProtocol41