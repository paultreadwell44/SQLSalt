/*************************************************************
Author: Thomas Stringer
Date Created: 3/25/2012

Script Description:
	the create script for the LOGON TRIGGER to deny login 
	connectivity based off of the deny admissions table
*************************************************************/
use master
go

if exists 
(
	select * 
	from master.sys.server_triggers 
	where name = 'logon_trigger_deny_by_time'
)
	drop trigger logon_trigger_deny_by_time
	on all server
go

create trigger logon_trigger_deny_by_time
on all server 
with execute as self
for logon
as

	declare 
		@current_login nvarchar(256),
		@current_weekday int,
		@current_time time
		
	select 
		@current_login = original_login(),
		@current_weekday = datepart(dw, getdate()),
		@current_time = cast(getdate() as time)
		
	if exists
	(
		select *
		from master.dbo.server_login_admission
		where login_name = @current_login
		and deny_day = @current_weekday
		and 
		(
			@current_time between deny_time_begin and deny_time_end
			or deny_full_day = 1
		)
	)
		begin
			rollback
		end

go