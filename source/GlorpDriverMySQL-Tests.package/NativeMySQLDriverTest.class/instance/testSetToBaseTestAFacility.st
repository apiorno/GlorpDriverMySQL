Tests
testSetToBaseTestAFacility
	super testSetToBaseTestAFacility.
	PharoDatabaseAccessor DefaultDriver: self class nativeDriver.
	GlorpDatabaseLoginResource current: nil.
	GlorpDatabaseLoginResource defaultLogin: self class glorpBackendFacility login