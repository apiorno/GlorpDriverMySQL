api
acquireConnectionIfError: errorBlock
      | connection |

	connection := self nextAvailableConnection.
	connection ifNil: [
		"All connections are stale and have been purged, grab some fresh ones"
		self connect: self loginCredentials. 
		connection := self nextAvailableConnection.
	].

	^ connection
