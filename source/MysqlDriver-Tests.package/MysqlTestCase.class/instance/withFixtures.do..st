as yet unclassified
withFixtures: fixtureNameList do: testBlock
	fixtureNameList do: [:each | self loadOneFixture: each].
	testBlock value: self resourceConnection 
	