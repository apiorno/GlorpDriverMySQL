Class {
	#name : #MysqlResultSetHeader,
	#superclass : #MysqlPacket,
	#instVars : [
		'fieldCount',
		'extra'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlResultSetHeader >> fieldCount [
	^ fieldCount 
]

{ #category : #Parsing }
MysqlResultSetHeader >> parse [
	fieldCount := self decodeLcbFrom: inStream.
	"exrta field may appear for some results (like show column)"
	inStream atEnd ifFalse: [extra := self decodeLcbFrom: inStream]
	
]
