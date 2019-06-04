Class {
	#name : #MysqlDriverSpec,
	#superclass : #Object,
	#instVars : [
		'host',
		'port',
		'user',
		'password',
		'database',
		'options'
	],
	#category : 'MySQLDriverCoreModel-Driver'
}

{ #category : #Accessing }
MysqlDriverSpec >> database: dbName [
	database := dbName
]

{ #category : #Accessing }
MysqlDriverSpec >> db [
	^ database
]

{ #category : #Accessing }
MysqlDriverSpec >> db: dbName [
	database := dbName
]

{ #category : #Accessing }
MysqlDriverSpec >> host [
	^ host
]

{ #category : #Accessing }
MysqlDriverSpec >> host: server [
	host := server
]

{ #category : #Accessing }
MysqlDriverSpec >> options: driverOptions [
	options := driverOptions
]

{ #category : #Accessing }
MysqlDriverSpec >> password [
	^ password
]

{ #category : #Accessing }
MysqlDriverSpec >> password: userPassword [
	password := userPassword
]

{ #category : #Accessing }
MysqlDriverSpec >> port [
	^ port
]

{ #category : #Accessing }
MysqlDriverSpec >> port: serverPort [
	port := serverPort
]

{ #category : #Accessing }
MysqlDriverSpec >> user [
	^ user
]

{ #category : #Accessing }
MysqlDriverSpec >> user: userName [
	user := userName
]
