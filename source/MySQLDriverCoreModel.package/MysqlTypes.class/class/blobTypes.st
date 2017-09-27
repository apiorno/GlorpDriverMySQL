Accessing
blobTypes
	blobTypes ifNil: [
		blobTypes := Array 
			with: TypeTINYBLOB with: TypeMEDIUMBLOB with: TypeBLOB with: TypeLONGBLOB ].
	^ blobTypes
	