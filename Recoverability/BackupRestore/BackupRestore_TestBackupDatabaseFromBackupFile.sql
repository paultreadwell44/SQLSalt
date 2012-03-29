/**********************************************************
Author: Thomas Stringer
Create Date: 3/29/2012

Description:
	this stored procedure is designed to take a backup
	file and do a temporary restore and DBCC CHECKDB in 
	order to determine the legitmacy and integrity of the
	backed up database
	
Usage:
	exec sp_backup_restore_test
		@backup_filename = 'C:\SomeBackup.bak',
		@restore_temp_path = 'C:\SomeDirectory\',
		@backup_set_file_number = 4
	go
	
	-- default to the first backup set in the bak file
	exec sp_backup_restore_test
		@backup_filename = 'C:\SomeBackup.bak',
		@restore_temp_path = 'C:\AnotherDir'
	go
**********************************************************/
use master
go

if object_id('dbo.sp_backup_restore_test') is not null
	drop procedure dbo.sp_backup_restore_test
go

create procedure dbo.sp_backup_restore_test
	@backup_filename nvarchar(1000),
	@restore_temp_path nvarchar(1000),
	@backup_set_file_number int = 1
as
	set nocount on;
	
	declare 
		@exec_cmd_filelistonly nvarchar(1000),
		@exec_cmd_headeronly nvarchar(1000),
		@database_name nvarchar(128),
		@database_name_suffix nvarchar(16) = '_restTest',
		@drive_space_required_mb int,
		@drive_space_available_mb int,
		@drive_space_tempbuffer_mb int = 1024,	-- temp drive buffer
		@dbcc_checkdb_logsearch nvarchar(128)
	
	select
		@exec_cmd_filelistonly = 'restore filelistonly from disk = ''' + 
			@backup_filename + ''' with file = ' + 
			cast(@backup_set_file_number as nvarchar),
		@exec_cmd_headeronly = 'restore headeronly from disk = ''' +
			@backup_filename + ''' with file = ' +
			cast(@backup_set_file_number as nvarchar)

	if exists
	(
		select *
		from tempdb.sys.tables
		where name like '#restore_filelistonly_result%'
	)
		drop table #restore_filelistonly_result
	
	create table #restore_filelistonly_result
	(
		LogicalName nvarchar(128) null,
		PhysicalName nvarchar(260) null,
		Type char(1) null,
		FileGroupName nvarchar(128) null,
		Size numeric(20, 0) null,
		MaxSize numeric(20, 0) null,
		FileId bigint null,
		CreateLSN numeric(25,0) null,
		DropLSN numeric(25,0) null,
		UniqueId uniqueidentifier null,
		ReadOnlyLSN numeric(25,0) null,
		ReadWriteLSN numeric(25,0) null,
		BackupSizeInBytes bigint null,
		SourceBlockSize int null,
		FileGroupId int null,
		LogGroupGUID uniqueidentifier null,
		DifferentialBaseLSN numeric(25,0) null,
		DifferentialBaseGUID uniqueidentifier null,
		IsReadOnly bit null,
		IsPresent bit null,
		TDEThumbprint varbinary(32) null,
		NewFileName as 
			left
			(
				reverse(left(reverse(PhysicalName), charindex('\', reverse(PhysicalName)) - 1)),
				charindex('.', reverse(left(reverse(PhysicalName), charindex('\', reverse(PhysicalName)) - 1))) - 1
			) + '_restTest' + 
			right
			(
				reverse(left(reverse(PhysicalName), charindex('\', reverse(PhysicalName)) - 1)),
				4
			),
		SizeMB as cast(Size / 1024 / 1024 as int)
	)

	insert into #restore_filelistonly_result
	(
		LogicalName,
		PhysicalName,
		Type,
		FileGroupName,
		Size,
		MaxSize,
		FileId,
		CreateLSN,
		DropLSN,
		UniqueId,
		ReadOnlyLSN,
		ReadWriteLSN,
		BackupSizeInBytes,
		SourceBlockSize,
		FileGroupId,
		LogGroupGUID,
		DifferentialBaseLSN,
		DifferentialBaseGUID,
		IsReadOnly,
		IsPresent,
		TDEThumbprint
	)
	exec(@exec_cmd_filelistonly)
	
	if exists
	(
		select *
		from tempdb.sys.tables
		where name like '#restore_headeronly_result%'
	)
		drop table #restore_headeronly_result
		
	create table #restore_headeronly_result
	(
		BackupName nvarchar(128) null,
		BackupDescription nvarchar(255) null,
		BackupType smallint null,
		ExpirationDate datetime null,
		Compressed bit null,
		Position smallint null,
		DeviceType tinyint null,
		UserName nvarchar(128) null,
		ServerName nvarchar(128) null,
		DatabaseName nvarchar(128) null,
		DatabaseVersion int null,
		DatabaseCreationDate datetime null,
		BackupSize numeric(20, 0) null,
		FirstLSN numeric(25, 0) null,
		LastLSN numeric(25, 0) null,
		CheckpointLSN numeric(25, 0) null,
		DatabaseBackupLSN numeric(25, 0) null,
		BackupStartDate datetime null,
		BackupFinishDate datetime null,
		SortOrder smallint null,
		CodePage smallint null,
		UnicodeLocaleId int null,
		UnicodeComparisonStyle int null,
		CompatibilityLevel tinyint null,
		SoftwareVendorId int null,
		SoftwareVersionMajor int null,
		SoftwareVersionMinor int null,
		SoftwareVersionBuild int null,
		MachineName nvarchar(128) null,
		Flags int null,
		BindingID uniqueidentifier null,
		RecoveryForkID uniqueidentifier null,
		Collation nvarchar(128) null,
		FamilGUID uniqueidentifier null,
		HasBulkLoggedData bit null,
		IsSnapshot bit null,
		IsReadOnly bit null,
		IsSingleUser bit null,
		HasBackupChecksums bit null,
		IsDamaged bit null,
		BeginsLogChain bit null,
		HasIncompleteMetData bit null,
		IsForceOffline bit null,
		IsCopyOnly bit null,
		FirstRecoveryForkID uniqueidentifier null,
		ForkPointLSN numeric(25, 0) null,
		RecoveryModel nvarchar(60) null,
		DifferentialBaseLSN numeric(25, 0) null,
		DifferentialBaseGUID uniqueidentifier null,
		BackupTypeDescription nvarchar(60) null,
		BackupSetGUID uniqueidentifier null,
		CompressedBackupSize bigint null
	)
	
	insert into #restore_headeronly_result
	(
		BackupName,
		BackupDescription,
		BackupType,
		ExpirationDate,
		Compressed,
		Position,
		DeviceType,
		UserName,
		ServerName,
		DatabaseName,
		DatabaseVersion,
		DatabaseCreationDate,
		BackupSize,
		FirstLSN,
		LastLSN,
		CheckpointLSN,
		DatabaseBackupLSN,
		BackupStartDate,
		BackupFinishDate,
		SortOrder,
		CodePage,
		UnicodeLocaleId,
		UnicodeComparisonStyle,
		CompatibilityLevel,
		SoftwareVendorId,
		SoftwareVersionMajor,
		SoftwareVersionMinor,
		SoftwareVersionBuild,
		MachineName,
		Flags,
		BindingID,
		RecoveryForkID,
		Collation,
		FamilGUID,
		HasBulkLoggedData,
		IsSnapshot,
		IsReadOnly,
		IsSingleUser,
		HasBackupChecksums,
		IsDamaged,
		BeginsLogChain,
		HasIncompleteMetData,
		IsForceOffline,
		IsCopyOnly,
		FirstRecoveryForkID,
		ForkPointLSN,
		RecoveryModel,
		DifferentialBaseLSN,
		DifferentialBaseGUID,
		BackupTypeDescription,
		BackupSetGUID,
		CompressedBackupSize
	)
	exec(@exec_cmd_headeronly)
	
	-- get the database name
	select @database_name = DatabaseName
	from #restore_headeronly_result
	
	-- set the database name as the same with a suffix
	select @database_name += @database_name_suffix
	
	-- get the drive space required to do a restore
	select @drive_space_required_mb = sum(SizeMB)
	from #restore_filelistonly_result
	
	if exists
	(
		select *
		from tempdb.sys.tables
		where name like '#fixed_drives%'
	)
		drop table #fixed_drives
		
	create table #fixed_drives
	(
		drive_name char(3) not null,
		free_space_mb int not null
	)

	insert into #fixed_drives
	exec master.sys.xp_fixeddrives
	
	select
		@drive_space_available_mb = free_space_mb
	from #fixed_drives
	where drive_name = left(@restore_temp_path, 1)
	
	-- check to make sure the temp path drive exists
	if @drive_space_available_mb is null
		begin
			raiserror('Unrecognized temp path drive', 16, 1)
			return -1
		end
	
	-- make sure there is enough space on the drive with a 1 GB buffer
	if 
		@drive_space_available_mb < 	
		@drive_space_required_mb + @drive_space_tempbuffer_mb
		begin
			raiserror('Insufficient temp drive space', 16, 1)
			return -1
		end
		
	-- ensure that the temp path has a trailing slash
	if right(@restore_temp_path, 1) <> '\'
		select @restore_temp_path += '\'
	
	-- do the restored database
	declare 
		@restore_cmd nvarchar(1000),
		@move_file nvarchar(512)
	
	select @restore_cmd = 
		'restore database ' + @database_name +
		' from disk = ''' + @backup_filename + 
		''' with file = ' + 
		cast(@backup_set_file_number as nvarchar) + ', '
	
	-- use a cursor to iterate over the database files
	--	in order to handle an unknown amount of database files
	--	for the tested backed up database	
	declare file_iterate cursor for
	select 
		'move ''' + LogicalName + 
		''' to ''' + @restore_temp_path + NewFileName + ''','
	from #restore_filelistonly_result
	
	open file_iterate
	
	fetch next
	from file_iterate
	into @move_file
	
	while @@fetch_status = 0
	begin
		select @restore_cmd += @move_file
		
		fetch next
		from file_iterate
		into @move_file
	end
	
	close file_iterate
	deallocate file_iterate
	
	-- remove the trailing comma
	select @restore_cmd = left(@restore_cmd, len(@restore_cmd) - 1)
	
	-- restore the database and run DBCC CHECKDB
	exec(@restore_cmd)	
	dbcc checkdb(@database_name)
	with no_infomsgs
	
	-- read the error log and show the DBCC CHECKDB result
	select 
		@dbcc_checkdb_logsearch = 'dbcc checkdb (' + @database_name + ')'
	
	if exists
	(
		select *
		from tempdb.sys.tables
		where name like '#errorlog%'
	)
		drop table #errorlog
		
	create table #errorlog
	(
		LogDate datetime null,
		ProcessInfo nvarchar(128) null,
		Text nvarchar(2000) null
	)
	
	insert into #errorlog
	(
		LogDate,
		ProcessInfo,
		Text
	)
	exec master.sys.xp_readerrorlog 0, 1, @dbcc_checkdb_logsearch
	
	select top 1 Text 
	from #errorlog
	order by LogDate desc
	
	-- drop the test restored database
	exec('drop database ' + @database_name)
	
go