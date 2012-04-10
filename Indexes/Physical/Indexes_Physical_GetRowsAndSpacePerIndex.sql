/*************************************************************************
Author: Thomas Stringer
Created on: 4/10/2012

Description:
	retrieve row counts for all indexes in the database, as well as 
	total reserved space and reserved pages

Notes:
	change 'YourDatabase' to the desired database
*************************************************************************/
use YourDatabase
go

select
	object_name(p.object_id) as table_name,
	i.name as index_name,
	i.type_desc as index_type,
	ps.row_count,
	ps.reserved_page_count,
	ps.reserved_page_count * 8 as reserved_space_kb
from sys.partitions p
inner join sys.indexes i
on p.object_id = i.object_id
and p.index_id = i.index_id
inner join sys.objects o
on p.object_id = o.object_id
inner join sys.dm_db_partition_stats ps
on p.partition_id = ps.partition_id
where o.is_ms_shipped = 0
order by ps.row_count desc	-- ordered to show largest rows first