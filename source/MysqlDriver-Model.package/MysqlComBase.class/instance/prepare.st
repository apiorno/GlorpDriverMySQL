as yet unclassified
prepare
	| cmd |
	cmd := MysqlCommand new.
	cmd command: self commandCode arg: self commandArg.
	^ cmd