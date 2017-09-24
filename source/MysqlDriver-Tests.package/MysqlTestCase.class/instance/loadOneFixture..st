as yet unclassified
loadOneFixture: fixtureName
	| fixtureSel fixtureStmtList conn resp |
	fixtureSel := 'fixture', fixtureName capitalized.
	fixtureStmtList := self class fixtureClass perform: fixtureSel asSymbol.
	fixtureStmtList do: [:stmt |
		conn := self resourceConnection.
		resp := conn query: stmt.
		resp isError 
			ifTrue: [self error: 'Error loading fixture from ', fixtureSel]]
	