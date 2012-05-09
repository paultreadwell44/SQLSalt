/********************************************************************
Author: Thomas Stringer
Created on: 5/8/2012

Description:
	this query returns all cached procedure plans, including when 
	they were cached/compiled and last executed

Notes:
	- change 'YourDatabase' to the database at hand
********************************************************************/

use YourDatabase
go

select
	db_name(database_id) as database_name,
	object_name(object_id) as sp_name,
	cached_time,
	last_execution_time
from sys.dm_exec_procedure_stats
where database_id = db_id('YourDatabase')