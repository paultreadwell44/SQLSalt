/********************************************************************
Author: Thomas Stringer
Created on: 6/2/2012

Description:
	this script creates database objects that record availabe disk 
	space for drives that contain database files.  
	
	The stored proc can be scheduled through SQL Server Agent to run 
	how often you'd like to check available space. It raises a 
	user-defined error, so an Alert can be created to notify an 
	Operator when the error was raised.

Notes:
	- 2 objects and an error message are created:
		dbo.drive_space: stores the historical available space for 
			the drives.  This table can be used for trending over a 
			long period of time
		dbo.fill_drive_space: stored proc to fill the table 
			dbo.drive_space and raise an error (defaults to 50001, 
			and this should be changed in the proc definition if 
			that ud error is already created) for an Alert to get
			fired off
		error(50001): this is a user-defined "low disk" error. Change 
			this error number so it can be implemented in your 
			current environment.  WARNING: IF YOU CHANGE THE ERROR 
			NUMBER, BE SURE TO MODIFY THE STORED PROC CODE TO 
			RAISERROR ON THE NEWLY CHANGED ERROR NUMBER

	- change the owning database to your desired database to house 
	these objects.  I have defaulted to my 'DBA' database, but modify 
	accordingly
********************************************************************/

use DBA;
go

-- ************** CREATE DRIVE SPACE STORAGE TABLE ****************
if exists
(
	select *
	from sys.tables
	where name = 'drive_space'
)
	drop table dbo.drive_space;
go
create table dbo.drive_space
(
	drive_space_id int identity(1, 1) not null
		primary key clustered,
	drive_name char(1) not null,
	free_space_mb int not null,
	datetime_stamp datetime not null
		default current_timestamp
);
go
-- ****************************************************************

-- ************* ADD ERROR MESSAGE FOR ALERTS *********************
-- Note: if the msgnum is already taken (defaults to the first 
--	possible user-defined error message number), then specify
--	a different message number.  WARNING: BE SURE TO CHANGE THE
--	STORED PROC CODE BELOW TO REFLECT NEW MSGNUM!!!!!
exec sp_addmessage 
	@msgnum = 50001, 
	@severity = 17, 
	@msgtext = 'Low drive space',
	@with_log = 'true'; 
go
-- ****************************************************************

-- ******** CREATE PROC TO CHECK FREE SPACE AND THROW ERROR *******
if exists
(
	select *
	from sys.sql_modules
	where object_id = object_id('fill_drive_space')
)
	drop proc dbo.fill_drive_space;
go
create procedure dbo.fill_drive_space
	@low_space_threshold_mb int
as
	set nocount on;

	declare 
		@current_min_space_mb int;

	create table #fixeddrives
	(
		drive char(1) not null,
		mb_free int not null
	);

	insert into #fixeddrives
	exec xp_fixeddrives;

	-- only insert drives that contain database files for this instance
	insert into dbo.drive_space
	(
		drive_name,
		free_space_mb
	)
	select
		fd.drive,
		fd.mb_free
	from #fixeddrives fd
	inner join 
	(
		select distinct
			left(physical_name, 1) as drive_root
		from sys.master_files
	) mf
	on fd.drive = mf.drive_root;

	drop table #fixeddrives;
	
	select 
		@current_min_space_mb = min(free_space_mb)
	from dbo.drive_space
	where datediff(second, datetime_stamp, current_timestamp) <= 10;

	if @current_min_space_mb <= @low_space_threshold_mb
		begin
			raiserror(50001, 0, 0);
		end
go
-- ****************************************************************