select
	sum(s.reserved_page_count) as reserved_page_count,
	sum(s.reserved_page_count * 8) as reserved_space_kb,
	sum(s.row_count) as row_count
from sys.dm_db_partition_stats s
inner join sys.objects o
on s.object_id = o.object_id
where o.type in ('U')
