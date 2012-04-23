/********************************************************************
Author: Thomas Stringer
Created on: 4/22/2012

Description:
	this query selects the partition details given a particular 
	partition_id

Notes:
	- replace 'YourDatabase' with the database at hand

	- set @partition_id to the partition you'd like to query off of
********************************************************************/

use YourDatabase
go

declare @partition_id bigint = 000000000000

select
	p.partition_id,
	o.name as table_name,
	i.name as index_name,
	i.type_desc
from sys.partitions p
inner join sys.objects o
on o.object_id = p.object_id
inner join sys.indexes i
on o.object_id = i.object_id
and p.index_id = i.index_id
where partition_id = @partition_id