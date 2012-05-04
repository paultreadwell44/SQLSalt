/********************************************************************
Author: Thomas Stringer
Created on: 5/3/2012

Description:
	gets total plan cache, data cache, and total cache consumed per 
	database
********************************************************************/

select
	dc.database_id,
	dc.database_name,
	dc.data_cache_space_kb,
	pc.plan_cache_space_kb,
	isnull(dc.data_cache_space_kb, 0) + isnull(pc.plan_cache_space_kb, 0) as total_cache_space_kb
from
(
	select
		database_id,
		db_name(database_id) as database_name,
		count(page_id) * 8 as data_cache_space_kb
	from sys.dm_os_buffer_descriptors
	where database_id <> 32767
	group by database_id
) dc
full outer join
(
	select
		s.dbid,
		db_name(s.dbid) as database_name,
		sum(p.size_in_bytes) / 1024 as plan_cache_space_kb
	from sys.dm_exec_cached_plans p
	cross apply sys.dm_exec_sql_text(p.plan_handle) s
	where s.dbid <> 32767
	group by s.dbid
) as pc
on dc.database_id = pc.dbid
order by total_cache_space_kb desc