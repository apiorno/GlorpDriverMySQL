Fixtures
fixtureBlobs
	^ #(
	'insert into 
		testBlobs (tinyblobValue, blobValue, mediumblobValue, longBlobValue)
	values 
		(''0123456789'', ''0123456789'', ''0123456789'', ''0123456789''),
		(''1234567890'', null, null, ''1234567890'')'
	)