Accessing
atIndex: indx
	^ columnStrings at: indx ifAbsent: [MysqlInvalidRowAccess signal: 'No data at this index']
	