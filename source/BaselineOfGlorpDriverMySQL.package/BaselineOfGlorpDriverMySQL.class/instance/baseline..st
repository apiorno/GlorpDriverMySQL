baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			self setUpDependenciesFor: spec.
			spec
				package: 'MySQLDriverCoreModel'with: [ spec requires: #('Glorp') ];
				package: 'MySQLDriverCoreTests'
					with: [ spec requires: #('MySQLDriverCoreModel') ];
				package: 'MySQLGlorpDriverModel'with: [ spec requires: #('Glorp') ];
				package: 'MySQLGlorpDriverTests' with: [ spec requires: #('MySQLGlorpDriverModel') ].
			spec
				group: 'Deployment' with: #('MySQLDriverCoreModel' 'MySQLGlorpDriverModel');
				group: 'Development'
					with: #('Deployment' 'MySQLDriverCoreTests' 'MySQLGlorpDriverTests');
				group: 'default' with: #('Development') ]
