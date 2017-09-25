Accessing
atIndex: indx
	^ columnValues at: indx ifAbsent: [MysqlInvalidRowAccess signal: 'No data at this index']
	