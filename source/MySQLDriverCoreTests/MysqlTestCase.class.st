"
MySQL base TestCase
"
Class {
	#name : #MysqlTestCase,
	#superclass : #TestCase,
	#category : 'MySQLDriverCoreTests-Integ'
}

{ #category : #Accessing }
MysqlTestCase class >> fixtureClass [
	"Override this in order to offer test specific fixture class"
	^ MysqlTestFixture
	
]

{ #category : #Accessing }
MysqlTestCase class >> resourceClass [
	^ MysqlTestResource
]

{ #category : #Accessing }
MysqlTestCase class >> resources [
	^ Set new 
		add: self resourceClass; 
		yourself
]

{ #category : #Finalization }
MysqlTestCase >> cleanUpFixtureData [
	self class resourceClass current clearTestTables 
	
]

{ #category : #'Test Support' }
MysqlTestCase >> connection [
	^ self connectionForTest
	
]

{ #category : #'Test Support' }
MysqlTestCase >> connectionForTest [
	^ self class resourceClass current connectionForTest
	
]

{ #category : #'Test Support' }
MysqlTestCase >> driverSpec [
	^ self class resourceClass driverSpecWithDb
	
]

{ #category : #'Test Support' }
MysqlTestCase >> loadOneFixture: fixtureName [
	| fixtureSel fixtureStmtList conn resp |
	fixtureSel := 'fixture', fixtureName capitalized.
	fixtureStmtList := self class fixtureClass perform: fixtureSel asSymbol.
	fixtureStmtList do: [:stmt |
		conn := self resourceConnection.
		resp := conn query: stmt.
		resp isError 
			ifTrue: [self error: 'Error loading fixture from ', fixtureSel]]
	
]

{ #category : #'Test Support' }
MysqlTestCase >> resourceConnection [
	^ self class resourceClass current resourceConnection 
	
]

{ #category : #'Test Support' }
MysqlTestCase >> specForTest [
	^ self class resourceClass current specForTest
]

{ #category : #Finalization }
MysqlTestCase >> tearDown [
	self cleanUpFixtureData
	
]

{ #category : #'Test Support' }
MysqlTestCase >> withFixtures: fixtureNameList do: testBlock [
	fixtureNameList do: [:each | self loadOneFixture: each].
	testBlock value: self resourceConnection 
	
]
