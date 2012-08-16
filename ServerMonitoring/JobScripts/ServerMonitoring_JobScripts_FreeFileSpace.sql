use AdventureWorks2012;
go

if exists
(
	select 1
	from tempdb.sys.tables
	where name like '#fixeddrives%'
)
	drop table #fixeddrives;
go
create table #fixeddrives
(
	drive nchar(1) not null,
	mb_free int not null,
	kb_free as mb_free * 1024 persisted
);
go

insert into #fixeddrives(drive, mb_free)
exec xp_fixeddrives;

;with DatabaseFileInfo as
(
	select 
		db_name(mf.database_id) as database_name,
		mf.name as db_file_name,
		mf.size * 8 as total_size_kb,
		fileproperty(mf.name, 'SpaceUsed') * 8 as space_used_kb,
		case
			when mf.max_size = -1 then fd.kb_free
			when (mf.max_size - size) * 8 <= fd.kb_free then (mf.max_size - size) * 8
			when fd.kb_free < (mf.max_size - mf.size) * 8 then fd.kb_free
		end as available_growth_space_kb
	from sys.master_files mf
	left join #fixeddrives fd
	on left(mf.physical_name, 1) = fd.drive
	where database_id = db_id()
)
select
	database_name,
	db_file_name,
	total_size_kb,
	space_used_kb,
	total_size_kb - space_used_kb as free_space_kb,
	cast(space_used_kb * 1.0 / total_size_kb * 100.0 as decimal(5, 2))
		as percent_used,
	available_growth_space_kb
from DatabaseFileInfo