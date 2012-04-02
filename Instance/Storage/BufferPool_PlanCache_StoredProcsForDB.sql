/***********************************************************
Author: Thomas Stringer
Created On: 4/2/2012

Description:
	gets all of the compile procedures stored in the cache 
	as well as their consumed space (in KB) and their 
	textual definition
	
Notes:
	- this script gets stored proc cache based off of the 
		current database context (therefore, change the 
		"use ..." to reflect the desire cache scope)
***********************************************************/
use TestDB
go

select 
	db_name(st.dbid) as database_name,
	object_name(st.objectid) as name,
	p.size_in_bytes / 1024 as size_in_kb,
	st.text
from sys.dm_exec_cached_plans p
cross apply sys.dm_exec_sql_text(p.plan_handle) st
where p.objtype = 'proc'
and st.dbid = db_id()