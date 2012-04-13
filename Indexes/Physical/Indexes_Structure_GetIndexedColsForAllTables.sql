/********************************************************************
Author: Thomas Stringer
Created on: 4/11/2012

Description:
	this query retrieves all indexes and their corresponding 
	columns that make up the key and non-key columns of the index

Usage:
	replace 'YourDatabase' with the database you are looking to 
	retrieve index data from
********************************************************************/
use YourDatabase
go

select
	object_name(i.object_id) as table_name,
	i.name as index_name,
	i.type_desc,
	c.name as column_name,
	ic.is_included_column
from sys.indexes i
inner join sys.index_columns ic
on i.object_id = ic.object_id
and i.index_id = ic.index_id
inner join sys.objects o
on i.object_id = o.object_id
inner join sys.columns c
on c.object_id = i.object_id
and ic.column_id = c.column_id
where o.is_ms_shipped = 0
order by table_name, i.type_desc, index_name