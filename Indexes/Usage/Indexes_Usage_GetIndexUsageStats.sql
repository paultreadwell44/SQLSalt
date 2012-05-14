/********************************************************************
Author: Thomas Stringer
Created on: 5/14/2012

Description:
	this query returns index usage stats summary for the current 
	database

Notes:
	- change 'YourDatabase' to the desired db
********************************************************************/

use YourDatabase;
go

select
	db_name(us.database_id) as database_name,
	object_name(us.object_id) as object_name,
	i.name,
	us.user_seeks,
	us.user_scans,
	us.user_lookups,
	us.user_updates
from sys.dm_db_index_usage_stats us
inner join sys.indexes i
on us.object_id = i.object_id
and us.index_id = i.index_id
where us.database_id = db_id();