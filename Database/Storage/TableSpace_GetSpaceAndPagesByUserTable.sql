declare @table_name nvarchar(256)
set @table_name = 'Enter table name here'

select
	sub.name,
	sum(sub.reserved_page_count) as reserved_page_count,
	sum(sub.reserved_space_kb) as reserved_space_kb,
	sum(sub.row_count) as row_count,
	case sub.index_type
		when 1 then 'CI'
		when 0 then 'NCI'
		else 'HEAP'
	end as index_desc
from
(
	select 
		o.name,
		s.reserved_page_count as reserved_page_count,
		s.reserved_page_count * 8 as reserved_space_kb,
		s.row_count as row_count,
		case 
			when s.index_id = 1 then 1
			when s.index_id > 1 then 0
			else null
		end as index_type
	from sys.dm_db_partition_stats s
	inner join sys.objects o
	on s.object_id = o.object_id
	where o.type in ('U')
	and o.name = @table_name
) sub
group by sub.name, sub.index_type