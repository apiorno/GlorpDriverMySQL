as yet unclassified
testWarnings
	| conn resp |
	conn := self connection.
	
	"Change the sql_mode for the current session test (in case of strict mode enabled)"
	conn query: 'SET SESSION sql_mode = ''NO_ENGINE_SUBSTITUTION'';'.
	
	resp := conn query: 'insert into warn values(''1000'', ''value one'')'.
	self assert: resp isOkay.
	self assert: resp warningCount = 1.
		
	resp := conn query: 'insert into warn values
				(''256'', ''value one two three four five six seven eight none ten'')'.
	self assert: resp isOkay.
	self assert: resp warningCount = 2.
