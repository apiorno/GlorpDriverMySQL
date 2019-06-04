Class {
	#name : #MysqlQueryRowData,
	#superclass : #MysqlRowData,
	#instVars : [
		'columns'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlQueryRowData >> at: indx [
	^ self atIndex: indx
]

{ #category : #Accessing }
MysqlQueryRowData >> atIndex: indx [
	^ columns at: indx ifAbsent: [MysqlInvalidRowAccess signal: 'No data at this index']
]

{ #category : #Accessing }
MysqlQueryRowData >> columnCount: aCount [
	columns := Array new: aCount 
	
]

{ #category : #Parsing }
MysqlQueryRowData >> parse [
	|indx value |

	indx := 1.
	[inStream atEnd] whileFalse: [
		value := (self decodeLcsFrom: inStream) asString.
		columns at: indx put: value.
		indx := indx + 1].
	
]
