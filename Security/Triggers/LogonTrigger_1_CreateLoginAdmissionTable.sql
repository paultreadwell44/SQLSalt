/*************************************************************
Author: Thomas Stringer
Date Created: 3/25/2012

Script Description:
	this is the CREATE TABLE script that creates the base 
	table (as well as CHECK constraints) for the deny
	admissions reference table for the logon trigger
*************************************************************/
use master
go

if object_id('server_login_admission') is not null
	drop table dbo.server_login_admission
go
create table dbo.server_login_admission
(
	admission_id int identity(1, 1) not null primary key clustered,
	login_name nvarchar(256) not null,
	deny_day int not null 
		check (deny_day between 1 and 7),
	deny_time_begin time null,
	deny_time_end time null,
	deny_full_day bit not null default 0
)
go

alter table dbo.server_login_admission
add constraint CK_TimeOrFullDay check
(
	(
		deny_time_begin is not null
		and deny_time_end is not null
	)
	or deny_full_day = 1
)
go

alter table dbo.server_login_admission
add constraint CK_DenyTimeNullHandling check
(
	(
		deny_time_begin is null
		and deny_time_end is null
	) or
	(
		deny_time_begin is not null
		and deny_time_end is not null
	)
)
go

alter table dbo.server_login_admission
add constraint CK_DenyTimeRelativity check
(
	deny_time_begin < deny_time_end
	or
	(
		deny_time_begin is null
		and deny_time_end is null
	)
)
go