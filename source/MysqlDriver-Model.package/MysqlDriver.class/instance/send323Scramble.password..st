Writing
send323Scramble: seed password: password
	| scrmblPkt |
	scrmblPkt := Mysql323Scramble new.
	scrmblPkt password: password; scrambleBuff: seed.
	self writePacket: scrmblPkt.
	