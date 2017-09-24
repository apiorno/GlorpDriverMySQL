as yet unclassified
invalidHostNameConnectionSpec
	| connSpec |
	
	connSpec := self goodConnectionSpec .
	connSpec host: 'souldfail.nodomain.zzz' .
	
	^ connSpec