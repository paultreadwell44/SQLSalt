/********************************************************************
Author: Thomas Stringer
Created on: 4/12/2012

Description:
	this script retrieves all of the indexes for a particular table

Notes:
	replace 'YourDatabase' with the containing database
	
	replace 'Enter Table Name' with the table's name to retrieve 
	indexes from
********************************************************************/
use YourDatabase
go

declare @table_name as nvarchar(128) = 'Enter Table Name'

select
	t.name as table_name,
	i.name as index_name,
	i.index_id,
	i.type_desc
from sys.indexes i
inner join sys.tables t
on i.object_id = t.object_id
where t.name = @table_name
order by i.index_id