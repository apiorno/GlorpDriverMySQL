Class {
	#name : #MysqlDriverTest,
	#superclass : #TestCase,
	#instVars : [
		'connector'
	],
	#classInstVars : [
		'protocol'
	],
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #'Test Support' }
MysqlDriverTest >> badConnectionSpec [
	| connSpec |
	
	connSpec := self goodConnectionSpec .
	connSpec password: 'wrongpassword' .
	
	^ connSpec
]

{ #category : #'Test Support' }
MysqlDriverTest >> goodConnectionSpec [
	^ MysqlDriverSpec new
		host: 'localhost';
		port: 3306;
		user: 'root';
		password: '';
		yourself
]

{ #category : #'Test Support' }
MysqlDriverTest >> invalidHostNameConnectionSpec [
	| connSpec |
	
	connSpec := self goodConnectionSpec .
	connSpec host: 'souldfail.nodomain.zzz' .
	
	^ connSpec
]

{ #category : #Initialization }
MysqlDriverTest >> setUp [
	connector := MysqlDriver new
]

{ #category : #Finalization }
MysqlDriverTest >> tearDown [
	connector connected ifTrue: [connector disconnect]
]

{ #category : #Tests }
MysqlDriverTest >> testConnectAssorted [
	| connSpec |
	
	connSpec := self goodConnectionSpec .
	self assert: (connector connect: connSpec) isOkay.
	connector disconnect.
	
	connSpec := self badConnectionSpec .
	self assert: (connector connect: connSpec) isError.
	connector connected ifTrue: [connector disconnect].

	connSpec := self goodConnectionSpec .
	self assert: (connector connect: connSpec) isOkay .
	connector disconnect.

]

{ #category : #Tests }
MysqlDriverTest >> testConnectBad [
	| connSpec |
	connSpec := self badConnectionSpec .
	self assert: (connector connect: connSpec) isError .
	
]

{ #category : #Tests }
MysqlDriverTest >> testConnectGood [

	| connSpec resp |
	
	connSpec := self goodConnectionSpec.
	resp := connector connect: connSpec.
	self assert: resp isOkay.
	
]

{ #category : #Tests }
MysqlDriverTest >> testConnectWithDb [
	| connSpec resp |
	connSpec := self goodConnectionSpec.
	connSpec db: 'sodbxtest'.
	resp := connector connect: connSpec.
	self assert: resp isOkay.
	connector disconnect.

	connSpec db: 'sodbxtest2'.
	self assert: (connector connect: connSpec) isError.
	connector connected ifTrue: [ connector disconnect].

]

{ #category : #Tests }
MysqlDriverTest >> testDisconnect [

	| connSpec |
	
	connSpec := self goodConnectionSpec .
	self assert: (connector connect: connSpec) isOkay.
	self shouldnt: [connector disconnect] raise: MysqlNoConnectionError .
	self should: [connector disconnect] raise: MysqlNoConnectionError .
]

{ #category : #Tests }
MysqlDriverTest >> testHostLookupError [
	| connSpec |
	connSpec := self invalidHostNameConnectionSpec.
	self should: [connector connect: connSpec] raise: MysqlNameLookupFailure.

]
