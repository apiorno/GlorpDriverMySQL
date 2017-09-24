as yet unclassified
testErrorAtFirst
	| resp qString conn |
	
	qString := 
		'select * from t2;', "bad"
		'select * from t1 where id=''1'';', "good"
		'insert into t1 values(''name01'', ''value01'');', "good"
		'select * from t1;'. "good"
	conn := self connection.
	resp := conn query: qString.
	self assert: (resp isError and: [resp hasMoreResults not])
	