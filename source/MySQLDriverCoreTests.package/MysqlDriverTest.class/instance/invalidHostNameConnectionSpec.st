Test Support
invalidHostNameConnectionSpec
	| connSpec |
	
	connSpec := self goodConnectionSpec .
	connSpec host: 'souldfail.nodomain.zzz' .
	
	^ connSpec