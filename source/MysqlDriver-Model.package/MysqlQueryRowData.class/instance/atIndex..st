as yet unclassified
atIndex: indx
	^ columns at: indx ifAbsent: [MysqlInvalidRowAccess signal: 'No data at this index']