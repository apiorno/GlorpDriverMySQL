as yet unclassified
fixtureTimes
	^ #(
	'insert into 
		testTimes (dateValue, timeValue, datetimeValue, timestampvalue, yearValue)
	values 
		(''2011-07-01'', ''18:35:23'', ''2011-07-02 10:12:45'', ''1980-01-12 00:45:56'', ''1999''), 
		(''2011-06-01'', ''03 17:34:22'', ''2011-06-02 09:11:44'', ''1980-02-13 01:44:55'', ''2000''), 
		(null, null, null, null, null),
		(null, ''-16:33:21.3579'', null, ''1980-03-14 02:43:54'', ''2002'')' "null in quote is not null"
	)