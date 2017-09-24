as yet unclassified
resetAllPools
	self selmaPools valuesDo: [ :each | each reset ].
	SelmaPools := nil.