/********************************************************************
Author: Thomas Stringer
Created on: 4/18/2012

Description:
	this query returns detailed information about database files 
	to include stalls, bytes read, and ratios of reads to writes
********************************************************************/

select 
	db_name(fs.database_id) as database_name,
	mf.name,
	mf.physical_name,
	left(mf.physical_name, 2) as physical_drive,
	fs.num_of_reads,
	fs.num_of_writes,
	case
		when fs.num_of_writes > 0
			then fs.num_of_reads / fs.num_of_writes
		else -1 
	end	as reads_to_writes,
	fs.num_of_bytes_read,
	fs.num_of_bytes_written,
	case
		when fs.num_of_bytes_written > 0
			then fs.num_of_bytes_read / fs.num_of_bytes_written
		else -1
	end as bytes_read_to_bytes_written,
	fs.io_stall_read_ms,
	fs.io_stall_write_ms,
	fs.io_stall,
	fs.size_on_disk_bytes / 1024 as size_on_disk_kb
from sys.dm_io_virtual_file_stats(null, null) fs
inner join sys.master_files mf
on fs.database_id = mf.database_id
and fs.file_id = mf.file_id
order by fs.io_stall