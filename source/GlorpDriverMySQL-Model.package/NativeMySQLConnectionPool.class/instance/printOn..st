Printing
printOn: aStream 
	super printOn: aStream.
	aStream
		nextPutAll: ' ( SelmaPool has ';
		print: self queue size;
		nextPutAll: ' used slots)'