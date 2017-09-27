Accessing
queue
	^ queue ifNil: [queue := SharedQueue new]