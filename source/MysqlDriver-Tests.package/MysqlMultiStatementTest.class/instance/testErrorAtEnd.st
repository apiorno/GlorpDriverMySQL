as yet unclassified
testErrorAtEnd
	| resp qString conn |
	qString := 
		'select * from nameValue where id=''1'';', "good"
		'insert into nameValue (name, value) values(''name03'', ''value03'');', "good"
		'select * from nameValue;', "good"
		'select * from t2;'. "bad"

	conn := self connection.
	resp := conn query: qString.
	self assert: (resp isResultSet and: [resp hasMoreResults]).
	self assert: (resp nextResult isOkay and: [resp nextResult hasMoreResults]).
	self assert: (resp nextResult nextResult isResultSet 
		and: [resp nextResult nextResult hasMoreResults = true]).
	self assert: (resp nextResult nextResult nextResult isError 
		and: [resp nextResult nextResult nextResult hasMoreResults = false]).
	