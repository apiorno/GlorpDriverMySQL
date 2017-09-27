Connection-Pooling
connectionPool
	"Get the appropriate connection pool - one per set of logins"
	^ self class poolFor: self loginCredentials 
		