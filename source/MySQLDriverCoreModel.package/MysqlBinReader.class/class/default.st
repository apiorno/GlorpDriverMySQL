Accessing
default
	defaultInstance isNil ifTrue: [ defaultInstance := self new ].
	^ defaultInstance