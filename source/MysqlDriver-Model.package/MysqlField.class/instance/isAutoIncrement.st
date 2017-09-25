Testing
isAutoIncrement
	^ (flags bitAnd: AutoIncrFlag) = AutoIncrFlag   
	