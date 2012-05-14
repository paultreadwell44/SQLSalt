/********************************************************************
Author: Thomas Stringer
Created on: 5/14/2012

Description:
	this query retrives a summary of index fragmentation for a 
	particular database, with a minimum page count filter

Note:
	- change 'YourDatabase' to the desired db

	- change @page_count_min to the minimum page count filter for 
	indexes
********************************************************************/

use YourDatabase;
go

declare 
	@page_count_min bigint = 1000;

select
	db_name(ps.database_id) as database_name,
	object_name(ps.object_id) as object_name,
	i.name as index_name,
	ps.index_id,
	ps.index_type_desc,
	ps.avg_fragmentation_in_percent,
	ps.page_count
from sys.dm_db_index_physical_stats
(
	db_id(),
	default,
	default,
	default,
	'detailed'
) ps
inner join sys.indexes i
on ps.object_id = i.object_id
and ps.index_id = i.index_id
where ps.page_count >= @page_count_min
order by ps.avg_fragmentation_in_percent desc;