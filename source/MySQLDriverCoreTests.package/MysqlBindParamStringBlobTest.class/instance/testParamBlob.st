Tests
testParamBlob
	theParam bindValue: (ByteArray new: 16rFF withAll: 16rAA).
	self assert: theParam detectParamType equals: MysqlTypes typeTINYBLOB.
	self assert: theParam isUnsigned.
	theParam bindValue: (ByteArray new: 16rFFFF withAll: 16r55).
	self assert: theParam detectParamType equals: MysqlTypes typeBLOB.
	self assert: theParam isUnsigned.
	theParam bindValue: (ByteArray new: 16r20000 withAll: 16rAA).
	self
		assert: theParam detectParamType
		equals: MysqlTypes typeMEDIUMBLOB.
	self assert: theParam isUnsigned.
	theParam bindValue: (ByteArray new: 16r1000000 withAll: 16r55).
	self assert: theParam detectParamType equals: MysqlTypes typeLONGBLOB.
	self assert: theParam isUnsigned