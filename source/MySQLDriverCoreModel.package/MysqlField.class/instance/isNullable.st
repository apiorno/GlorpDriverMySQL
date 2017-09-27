Testing
isNullable
	^ (flags bitAnd: NotNullFlag) ~= NotNullFlag  
	