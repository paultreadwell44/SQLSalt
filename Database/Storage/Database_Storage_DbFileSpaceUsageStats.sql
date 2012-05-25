/********************************************************************
Author: Thomas Stringer
Created on: 5/24/2012

Description:
	this query returns database file size, space used, and free space 
	information for the particular database

Notes:
	- change 'YourDatabase' to the desired database
********************************************************************/

use YourDatabase;
go

;with DatabaseFileInfo as
(
	select 
		db_name(database_id) as database_name,
		name as db_file_name,
		size * 8 as total_size_kb,
		fileproperty(name, 'SpaceUsed') * 8 as space_used_kb
	from sys.master_files
	where database_id = db_id()
)
select
	database_name,
	db_file_name,
	total_size_kb,
	space_used_kb,
	total_size_kb - space_used_kb as free_space_kb,
	cast(space_used_kb * 1.0 / total_size_kb * 100.0 as decimal(5, 2))
		as percent_used
from DatabaseFileInfo