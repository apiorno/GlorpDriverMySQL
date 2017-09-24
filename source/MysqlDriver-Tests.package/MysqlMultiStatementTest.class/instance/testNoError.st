as yet unclassified
testNoError
	| resp qString conn |
	qString := 
		'select * from nameValue where id=''1'';', "good"
		'insert into nameValue (name, value) values(''name04'', ''value04'');', "good"
		'select * from nameValue;'. "good"
	conn := self connection.
	resp := conn query: qString.
	self assert: (resp isResultSet and: [resp hasMoreResults]).
	self assert: (resp nextResult isOkay and: [resp nextResult hasMoreResults]).
	self assert: (resp nextResult nextResult isResultSet 
		and: [resp nextResult nextResult hasMoreResults = false])
	