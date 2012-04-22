/********************************************************************
Author: Thomas Stringer
Created on: 4/21/2012

Description:
	this script get foreign key references and their corresponding 
	objects

Notes:
	- replace 'YourDatabase' with the database you would like to 
	query

	- set @referencing_table_name to the fk table name (or leave 
	null to not filter by this param)

	- set @referenced_table_name to the pk/uq containing table (or 
	leave null to not filter by this param)

	- set @referencing_key_name to the fk name (or leave null to not 
	filter by this param)

	- set @referenced_key_name to the pk/uq name (or leave null to 
	not filter by this param)
********************************************************************/

use YourDatabase
go

declare
	@referencing_table_name nvarchar(128) = null,
	@referenced_table_name nvarchar(128) = null,
	@referencing_key_name nvarchar(128) = null,
	@referenced_key_name nvarchar(128) = null

select *
from
(
	select 
		object_name(fk.parent_object_id) as parent_table_name,
		fk.name as foreign_key_name,
		object_name(fk.referenced_object_id) as referenced_table_name,
		pk.name as referenced_key_name,
		pk.type
	from sys.foreign_keys fk
	inner join sys.key_constraints pk
	on fk.referenced_object_id = pk.parent_object_id
) a
where
	((@referencing_table_name is null) or (parent_table_name = @referencing_table_name)) and
	((@referenced_table_name is null) or (referenced_table_name = @referenced_table_name)) and
	((@referencing_key_name is null) or (foreign_key_name = @referencing_key_name)) and
	((@referenced_key_name is null) or (referenced_key_name = @referenced_key_name))