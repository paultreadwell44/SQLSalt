/********************************************************************
Author: Thomas Stringer
Created on: 4/26/2012

Description:
	this query gathers the most fragmented indexes based off of the 
	index page count, and ordered by percent fragmentation

Notes:
	- change 'YourDatabase' to the database at hand

	- @page_count_min has a default of 1000 pages for the 
	fragmentation result set, but feel free to alter that accordingly

	- uncomment the TOP clause to narrow down the query

	- uncomment the AND clause (of the WHERE clause) to narrow down 
	the query based off of a minimum fragmentation percentages
********************************************************************/

use YourDatabase
go

declare
	@page_count_min int = 1000

select -- top 10
	db_name(ps.database_id) as database_name,
	object_name(ps.object_id) as table_name,
	i.name as index_name,
	ps.index_type_desc,
	ps.index_level,
	ps.avg_fragmentation_in_percent,
	ps.page_count
from sys.dm_db_index_physical_stats
(
	db_id(),
	null,
	null,
	null,
	'detailed'
) ps
inner join sys.indexes i
on ps.object_id = i.object_id
and ps.index_id = i.index_id
where ps.page_count >= @page_count_min
--and ps.avg_fragmentation_in_percent >= 30
order by ps.avg_fragmentation_in_percent desc