as yet unclassified
createMiscTestTables
	| resp |
	self ddlMiscTestTables do: [:each |
		resp := conn query: each.
		resp isError ifTrue: [^ self error: 'Error creating misc test table: ', resp message]]
	