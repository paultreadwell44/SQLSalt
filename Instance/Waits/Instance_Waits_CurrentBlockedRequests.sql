/********************************************************************
Author: Thomas Stringer
Created on: 4/24/2012

Description:
	gets the current blocked requests and their details to include 
	sql text and query plan
********************************************************************/

select
	r.session_id,
	status,
	db_name(r.database_id) as database_name,
	user_name(r.user_id) as user_name,
	r.wait_time,
	r.wait_type,
	r.wait_resource,
	s.text as sql_text,
	p.query_plan
from sys.dm_exec_requests r
cross apply sys.dm_exec_sql_text(r.sql_handle) s
cross apply sys.dm_exec_query_plan(r.plan_handle) p
where r.status = 'suspended'