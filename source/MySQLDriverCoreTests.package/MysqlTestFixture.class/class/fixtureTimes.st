Fixtures
fixtureTimes
	^ #(
	'insert into 
		testTimes (dateValue, timeValue, datetimeValue, yearValue)
	values 
		(''2011-07-01'', ''18:35:23'', ''2011-07-02 10:12:45'', ''1999''), 
		(''2011-06-01'', ''03 17:34:22'', ''2011-06-02 09:11:44'', ''2000''), 
		(null, null, null, null),
		(null, ''-16:33:21.3579'', null, ''2002'')' "null in quote is not null"
	)