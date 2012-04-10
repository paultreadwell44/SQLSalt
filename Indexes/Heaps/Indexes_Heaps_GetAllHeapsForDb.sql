/**********************************************************************
Author: Thomas Stringer
Created on: 4/10/2012

Description:
	gets all HEAPS in the current database

Notes:
	change 'YourDatabase' to the database you are attempting to 
	retrieve HEAP info from
**********************************************************************/
use YourDatabase
go

select 
	object_name(i.object_id) as table_name,
	i.*
from sys.indexes i
inner join sys.objects o
on i.object_id = o.object_id
where i.type_desc = 'heap'
and o.is_ms_shipped = 0