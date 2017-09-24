as yet unclassified
glorpBackendFacility
	| facility |
	facility := GlorpBackendFacility new.
	facility login: self login.
	^ facility