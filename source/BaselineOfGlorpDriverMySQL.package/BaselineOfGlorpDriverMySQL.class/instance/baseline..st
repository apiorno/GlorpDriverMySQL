baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			self setUpDependenciesFor: spec.
			spec
				package: 'GlorpDriverMySQL-Model';
				package: 'GlorpDriverMySQL-Tests'
					with: [ spec requires: #('GlorpDriverMySQL-Model') ];
				package: 'MysqlDriver-Model';
				package: 'MysqlDriver-Tests' with: [ spec requires: #('MysqlDriver-Model') ].
			spec
				group: 'Deployment' with: #('GlorpDriverMySQL-Model' 'MysqlDriver-Model');
				group: 'Development'
					with: #('Deployment' 'GlorpDriverMySQL-Tests' 'MysqlDriver-Tests');
				group: 'default' with: #('Development') ]