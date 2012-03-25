/*************************************************************
Author: Thomas Stringer
Date Created: 3/25/2012

Script Description:
	the create procedure script to create the stored proc 
	that adds records to the deny admission table referenced 
	by the logon trigger
	
Usage:
	exec dbo.sp_add_server_login_admission
		@login_name = 'someLogin1',
		@deny_day = 1,		-- deny access on sundays
		@deny_full_day = 1	-- deny access for the whole day
	go
	
	exec dbo.sp_add_server_login_admission
		@login_name = 'someLogin2',
		@deny_day = 2,		-- deny access on mondays
		@deny_time_begin = '17:00',
		@deny_time_end = '23:00'	-- deny from 5pm to 11pm
	go
*************************************************************/
use master
go

if object_id('dbo.sp_add_server_login_admission') is not null
	drop procedure dbo.sp_add_server_login_admission
go

create procedure dbo.sp_add_server_login_admission
	@login_name nvarchar(256),
	@deny_day int,
	@deny_time_begin time = null,
	@deny_time_end time = null,
	@deny_full_day bit = 0
as

	set nocount on;
	
	-- check to make sure the login actually exists
	if suser_id(@login_name) is null
		begin
			raiserror
			(
				'Unknown login name', 
				16, 
				1
			)
			return -1
		end
	
	-- make sure the @deny_day is a valid day of the week
	if @deny_day not between 1 and 7
		begin
			raiserror
			(
				'Invalid deny day', 
				16, 
				1
			)
			return -1
		end
		
	if 
	(
		@deny_time_begin is null
		and @deny_time_end is not null
	) or
	(
		@deny_time_begin is not null
		and @deny_time_end is null
	)
		begin
			raiserror
			(
				'Both deny time parameters must have a value, 
				or both must be null', 
				16, 
				1
			)
			return -1
		end
		
	-- ensure @deny_time and @deny_full_day aren't null and 0
	if @deny_time_begin is null
	and @deny_full_day = 0
		begin
			raiserror
			(
				'Deny time cannot be null 
				if login is not denied for a whole day', 
				16, 
				1
			)
			return -1
		end
		
	insert into dbo.server_login_admission
	(
		login_name,
		deny_day,
		deny_time_begin,
		deny_time_end,
		deny_full_day
	)
	values
	(
		@login_name,
		@deny_day,
		@deny_time_begin,
		@deny_time_end,
		@deny_full_day
	)
	
go