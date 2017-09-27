Tests
testErrorAtMiddle
	| resp qString conn |
	qString := 
		'select * from nameValue where id=''1'';', "good"
		'insert into nameValue (name, value) values(''name02'', ''value02'');', "good"
		'select * from t2;', "bad"
		'select * from nameValue;'. "good"
	conn := self connection.
	resp := conn query: qString.
	self assert: (resp isResultSet and: [resp hasMoreResults]).
	self assert: (resp nextResult isOkay and: [resp nextResult hasMoreResults]).
	self assert: (resp nextResult nextResult isError 
		and: [resp nextResult nextResult hasMoreResults not]).
