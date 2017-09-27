Glorp-API
basicExecuteSQLString: aString
	| preparedRequest result rows emptyStream |
	emptyStream := ReadStream on: Array new.
	aString ifEmpty: [ ^ emptyStream ].
	preparedRequest := self prepare: aString.
	result := preparedRequest execute.
	result isResultSet
		ifFalse: [ ^ emptyStream ].
	rows := result rows collect: [ :each | each allValuesArrayed ].
	^ ReadStream on: rows asArray