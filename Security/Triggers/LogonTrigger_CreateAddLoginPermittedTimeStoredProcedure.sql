use master
go

if object_id('dbo.sp_add_server_login_admission') is not null
	drop procedure dbo.sp_add_server_login_admission
go

create procedure dbo.sp_add_server_login_admission
	@login_name nvarchar(256),
	@deny_day int,
	@deny_time time = null,
	@deny_full_day bit = 0
as

	set nocount on;
	
	-- check to make sure the login actually exists
	if suser_id(@login_name) is null
		begin
			raiserror('Unknown login name', 16, 1)
			return -1
		end
	
	-- make sure the @deny_day is a valid day of the week
	if @deny_day not between 1 and 7
		begin
			raiserror('Invalid deny day', 16, 1)
			return -1
		end
		
	-- ensure @deny_time and @deny_full_day aren't null and 0
	if @deny_time is null
	and @deny_full_day = 0
		begin
			raiserror('Deny time cannot be null if login not denied for a whole day', 16, 1)
			return -1
		end
	
go