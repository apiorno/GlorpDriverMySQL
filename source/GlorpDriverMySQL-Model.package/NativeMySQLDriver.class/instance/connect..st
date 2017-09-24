glorp-API
connect: aLogin

	| connectionSpec |
	connection  := self connectionClass new. 
	connectionSpec := self getDriverSpecFromLogin: aLogin .
	connection connect: connectionSpec . 
	^ connection