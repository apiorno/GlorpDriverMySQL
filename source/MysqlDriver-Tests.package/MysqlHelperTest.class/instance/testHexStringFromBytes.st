as yet unclassified
testHexStringFromBytes
	| bytes str |
	bytes := ByteArray new: 16.
	bytes 
		at: 1 put: 16r00;	at: 2 put: 16r11; at: 3 put: 16r22; at: 4 put: 16r33;
		at: 5 put: 16r44;	at: 6 put: 16r55; at: 7 put: 16r66; at: 8 put: 16r77;
		at: 9 put: 16r88;	at: 10 put: 16r99; at: 11 put: 16rAA; at: 12 put: 16rBB;
		at: 13 put: 16rCC; at: 14 put: 16rDD; at: 15 put: 16rEE; at: 16 put: 16rFF.
	
	str := MysqlHelper hexStringFromBytes: bytes.
	self assert: str = '00112233445566778899AABBCCDDEEFF'
	