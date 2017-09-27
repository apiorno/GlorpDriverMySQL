accessing
bindValue: aValue 
	| boundType |
	paramValue := aValue.
	(boundType := self detectParamType) ~= paramType 
		ifTrue: [
			paramType := boundType.
			newParamBound := true].
	unsignedFlag := self detectParamSign.
	