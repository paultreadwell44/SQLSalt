/**************************************************************
Author: Thomas Stringer
Created on: 4/10/2012

Description:
	this script retrieves valuable information regarding 
	log file consumption

Notes:
	encapsulate this into a stored procedure for reusability 
	in environments
**************************************************************/
use master
go

-- first populate the DBCC SQLPERF(LOGSPACE) result
declare 
	@dbcc_sqlperf nvarchar(100) = 'dbcc sqlperf(logspace)'

if exists (select * from tempdb.sys.tables where name like '#db_logspace_used%')
	drop table #db_logspace_used

create table #db_logspace_used
(
	database_name nvarchar(100) null,
	log_size_mb real null,
	log_space_used_percent decimal(4, 2) null,
	log_status int null
)

insert into #db_logspace_used
(
	database_name,
	log_size_mb,
	log_space_used_percent,
	log_status
)
exec(@dbcc_sqlperf)

-- retrieve fixed drive free space
if exists(select * from tempdb.sys.tables where name like '#fixed_drives%')
	drop table #fixed_drives

create table #fixed_drives
(
	drive_name char(3) not null,
	free_space_mb int not null
)

insert into #fixed_drives
exec master.sys.xp_fixeddrives


select
	lsu.database_name,
	lsu.log_space_used_percent,
	mf.size * 8.0 / 1024 as size_mb,
	(mf.size * 8.0 / 1024) * ((100 - lsu.log_space_used_percent) / 100) as log_space_remaining_mb,
	left(mf.physical_name, 1) as physical_drive,
	fd.free_space_mb as physical_drive_remaining_mb,
	mf.name as log_name,
	mf.physical_name,
		case mf.growth
			when 0 then 0
			else 1
		end
	as is_auto_growth,
		case mf.max_size
			when -1 then -1
			else mf.max_size * 8.0 / 1024
		end
	as max_size_mb
from #db_logspace_used lsu
inner join sys.master_files mf
on lsu.database_name = db_name(mf.database_id)
inner join sys.databases d
on d.database_id = mf.database_id
left join #fixed_drives fd
on fd.drive_name = left(mf.physical_name, 1)
where mf.type = 1
and d.recovery_model in (1, 2)	-- ensure only full and bulk-logged recovery models
order by lsu.log_space_used_percent desc