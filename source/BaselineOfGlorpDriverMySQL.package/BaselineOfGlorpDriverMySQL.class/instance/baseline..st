baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			self setUpDependenciesFor: spec.
			spec
				package: 'MySQLDriverCoreModel';
				package: 'MySQLDriverCoreTests'
					with: [ spec requires: #('MySQLDriverCoreModel') ];
				package: 'MySQLGlorpDriverModel';
				package: 'MySQLGlorpDriverTests' with: [ spec requires: #('MySQLGlorpDriverModel') ].
			spec
				group: 'Deployment' with: #('MySQLDriverCoreModel' 'MySQLGlorpDriverModel');
				group: 'Development'
					with: #('Deployment' 'MySQLDriverCoreTests' 'MySQLGlorpDriverTests');
				group: 'default' with: #('Development') ]
