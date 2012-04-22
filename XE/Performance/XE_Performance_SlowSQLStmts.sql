/********************************************************************
Author: Thomas Stringer
Created on: 4/17/2012

Description:
	this code creates an XE session to capture user SQL statements 
	that have a duration of 10 seconds or more

Notes:
	- ensure you alter the filename and path to match your 
	environment
********************************************************************/
create event session SlowStmts 
on server 
add event sqlserver.sql_statement_completed
(
	set 
		collect_parameterized_plan_handle = 0,
		collect_statement = 1
    action
	(
		sqlserver.database_name,
		sqlserver.session_id,
		sqlserver.username
	)
    where 
	(
		duration >= 10000000 and
		sqlserver.is_system <> 1
	)
)
add target package0.event_file
(
	set
		filename = 'C:\XeDir\SlotStmts.xel',
		max_file_size = 500
)
with 
(
	startup_state = off
)
go


-- start the session
alter event session SlowStmts
on server
state = start
go