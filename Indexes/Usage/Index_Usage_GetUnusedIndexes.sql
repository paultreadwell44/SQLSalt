/******************************************************
Author: Thomas Stringer
Create Date: 4/2/2012

Description:
	this script gets the unused indexes in the current
	database.  Consider investigation on the overhead 
	of the maintenance of unused indexes
******************************************************/

select
	object_name(i.object_id) as table_name,
	i.name as index_name
from sys.indexes i
inner join sys.tables t
on i.object_id = t.object_id
where not exists
(
	select
		*
	from sys.dm_db_index_usage_stats u
	where u.object_id = i.object_id
	and u.index_id = i.index_id
	and u.database_id = db_id()
)
and i.name is not null	-- don't include heaps