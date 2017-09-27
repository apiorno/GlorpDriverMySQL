Real
decimalWithScale: scale from: aStream
	| valueString |
	valueString := (MysqlHelper decodeLcsFrom: aStream) asString, 's', scale asString.
	^ valueString asNumber
	