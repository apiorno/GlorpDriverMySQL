Tests
testSequenceNumbering
	self
		assert: session getSequence = 0
		description: '0 right after creation'.
	self assert: (session validateSequence: 0).
	session updateSequence.
	self assert: session getSequence equals: 1.
	self assert: (session validateSequence: 1).
	255 timesRepeat: [ session updateSequence ].
	self assert: session getSequence = 0 description: 'Modulo 256'.
	self assert: (session validateSequence: 0).
	10 timesRepeat: [ session updateSequence ].
	self assert: session getSequence equals: 10.
	self assert: (session validateSequence: 10).
	session resetSequence.
	self assert: session getSequence equals: 0.
	self assert: (session validateSequence: 0)