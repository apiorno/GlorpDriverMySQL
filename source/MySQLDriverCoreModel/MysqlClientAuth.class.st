Class {
	#name : #MysqlClientAuth,
	#superclass : #MysqlPacket,
	#instVars : [
		'user',
		'password',
		'database',
		'scrambleBuff',
		'clientCaps',
		'charset',
		'serverCaps',
		'scrambleBuffMore'
	],
	#category : 'MySQLDriverCoreModel-Packet'
}

{ #category : #Accessing }
MysqlClientAuth >> charset: csNum [
	charset := csNum
]

{ #category : #Accessing }
MysqlClientAuth >> database: db [
	database := db
]

{ #category : #Initialization }
MysqlClientAuth >> initialize [
	clientCaps := CapLongFlag + CapTransactions + CapLongPassword + CapConnectWithDb.
	clientCaps := clientCaps + CapProtocol41 + CapSecureConnection.
]

{ #category : #Accessing }
MysqlClientAuth >> password: pwd [
	password := pwd.
]

{ #category : #Accessing }
MysqlClientAuth >> scrambleBuff: buffer [
	scrambleBuff := buffer.
]

{ #category : #Accessing }
MysqlClientAuth >> scrambleBuffMore: more [
	scrambleBuffMore := more
]

{ #category : #Accessing }
MysqlClientAuth >> serverCaps: caps [ 
	serverCaps := caps
]

{ #category : #Accessing }
MysqlClientAuth >> user: userName [
	user := userName
]

{ #category : #Writing }
MysqlClientAuth >> write [
	| flags scrmbl buffStream maxNetPacketLength |
	buffStream := WriteStream on: (ByteArray new: 1024).
	flags := serverCaps bitAnd: clientCaps.
	flags := flags bitOr: CapMultiStatements + CapMultiResults.
	buffStream
		nextPut: (flags digitAt: 1);
		nextPut: (flags digitAt: 2);
		nextPut: (flags digitAt: 3);
		nextPut: (flags digitAt: 4).
	maxNetPacketLength := self class maxNetPacketLength.
	buffStream
		nextPut: (maxNetPacketLength digitAt: 1);
		nextPut: (maxNetPacketLength digitAt: 2);
		nextPut: (maxNetPacketLength digitAt: 3);
		nextPut: (maxNetPacketLength digitAt: 4).
	buffStream nextPut: (charset digitAt: 1).
	buffStream nextPutAll: (ByteArray new: 23 withAll: 0).	"filler"
	buffStream nextPutAll: user asByteArray.
	buffStream nextPut: 0.	"null terminated"
	scrmbl := password isEmptyOrNil
		ifTrue: [ '' asByteArray ]
		ifFalse: [ MysqlHelper
				secureScramble: scrambleBuff , scrambleBuffMore
				with: password ].
	self encodeLcs: scrmbl on: buffStream.
	(flags bitAnd: CapConnectWithDb) = CapConnectWithDb
		ifTrue: [ database isEmptyOrNil
				ifFalse: [ buffStream nextPutAll: database asByteArray ].
			buffStream nextPut: 0	"null terminated" ].
	^ buffStream contents
]
