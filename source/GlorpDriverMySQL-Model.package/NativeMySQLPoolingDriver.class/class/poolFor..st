as yet unclassified
poolFor: aLogin
	"Get the appropriate connection pool - one per set of logins"
	^ self selmaPools
		"DO NOT use aLogin here as the key because it's #= checks for equal password. And if password are cleaned because
		passwords are discarded (connections are secure), this gives false. So if we want to use aLogin for key, they have to be 
		set secure: false. For this purpose we use #connectString."
		at: aLogin connectString
		ifAbsentPut: [ self nativeConnectionPool new ] 

