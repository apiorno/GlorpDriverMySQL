as yet unclassified
createTypeTestTables
	| resp |
	self ddlTypeTestTables do: [:each |
		resp := conn query: each.
		resp isError ifTrue: [^ self error: 'Error creating type test table: ', resp message]]
	