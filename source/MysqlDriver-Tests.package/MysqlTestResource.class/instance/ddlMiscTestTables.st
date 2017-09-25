Actions
ddlMiscTestTables
	^ #(
	'create table if not exists nameValue (
		id int not null auto_increment primary key,
		name varchar(256) not null unique key,
		value varchar(1024) not null default ''aeiou''
	) engine = InnoDB'
	
	'/* for testing warnings */
	create table if not exists warn (
		c1 tinyint not null,
		c2 varchar(32)
	)'

	'create table if not exists mix (
		name varchar(256) not null primary key,
		value decimal(21,9) default null
	) engine = InnoDB'
		
	'create table if not exists testMisc (
		name varchar(100) not null primary key,
		value varchar(1000) not null,
		entryOn date not null,
		notes varchar(1000)
	) engine = InnoDB'
	
	'create table if not exists testWideTable (
		id int auto_increment not null primary key,
		name varchar(100),
		shortDescription varchar(200),
		longDescription varchar(1000),
		categotyCode int,
		categoryName varchar(200),
		supplierCode int,
		supplierName varchar(200),
		colorCode int,
		colorName varchar(100),
		colorSource int,
		colorSourceName varchar(100),
		size int,
		attributeA varchar(100),
		attributeB varchar(100),
		attributeC varchar(100),
		attributeD varchar(100),
		attributeE varchar(100),
		attributeF varchar(100),
		attributeG varchar(100),
		attributeH varchar(100),
		attributeI varchar(100),
		attributeJ varchar(100),
		attributeK varchar(100),
		attributeL varchar(100),
		attributeM varchar(100),
		attributeN varchar(100),
		attributeO varchar(100),
		attributeP varchar(100),
		attributeQ varchar(100),
		attributeR varchar(100),
		attributeS varchar(100),
		attributeT varchar(100),
		attributeU varchar(100),
		attributeV varchar(100),
		attributeW varchar(100),
		attributeX varchar(100),
		attributeY varchar(100),
		attributeZ varchar(100)
	) engine = InnoDB'
	)