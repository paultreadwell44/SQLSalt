/****************************************************************
Author: Thomas Stringer
Created On: 3/26/2012

Description:
	this query gets parameters from the plan 
	cache and does calculations to retrieve 
	aggregations by object type
	
Output:
	objtype				: the type of object (i.e. stored proc)
	plan_count			: count of each objtype plans
	total_size_kb		: total size by objtype in the plan cache
	total_use_counts	: total times the obj is used
****************************************************************/

select
	objtype,
	count(*) as plan_count,
	sum(size_in_bytes) / 1024 as total_size_kb,
	sum(usecounts) as total_use_counts
from sys.dm_exec_cached_plans
group by objtype
order by total_size_kb desc