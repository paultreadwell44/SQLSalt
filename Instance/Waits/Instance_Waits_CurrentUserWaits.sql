/********************************************************************
Author: Thomas Stringer
Created on: 4/18/2012

Description:
	gets the current user session waits and data to go along with 
	them
********************************************************************/

select
	s.login_name,
	db_name(s.database_id) as database_name,
	t.wait_type,
	t.wait_duration_ms,
	t.blocking_session_id
from sys.dm_os_waiting_tasks t
inner join sys.dm_exec_sessions s
on t.session_id = s.session_id
where s.is_user_process = 1