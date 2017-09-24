as yet unclassified
send323Scramble
	| scrmblPkt |
	scrmblPkt := Mysql323Scramble new.
	scrmblPkt password: password; scrambleBuff: scrambleBuff.
	self writePacket: scrmblPkt
	