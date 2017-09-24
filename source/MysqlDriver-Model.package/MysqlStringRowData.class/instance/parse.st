parsing
parse
	super parse.
	columnStrings := columnValues collect: [:each | 
		each ifNil: ['NULL'] ifNotNil: [
			(each isKindOf: Date) ifTrue: [each yyyymmdd] ifFalse: [
				(each isKindOf: Time) ifTrue: [each print24] ifFalse: [
					"(each isKindOf: TimeStamp) ifTrue: [each asISOString] ifFalse: ["
					(each isKindOf: DateAndTime) ifTrue: [each asStringYMDHM] ifFalse: [
						each asString]]]]]
	 
	