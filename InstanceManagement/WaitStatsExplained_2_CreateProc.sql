/*************************************************************
Author: Thomas Stringer
Date Created: 3/19/2012

Script Description: 
	this creates the stored procedure in the master database
	that, when executed, will select the most egregious
	wait stats.  If the parameter is null, it will select
	all of the wait stats and order them by wait time desc
	
Use:
	exec dbo.sp_wait_stats_explained
	go
	
	exec dbo.sp_wait_stats_explained 10
	go
*************************************************************/
use master
go

if object_id('master.dbo.sp_wait_stats_explained') is not null
	drop procedure dbo.sp_wait_stats_explained
go

create procedure dbo.sp_wait_stats_explained
	@top_amount int = null
as
	set nocount on;

	select top (coalesce(@top_amount, 999999))
		ws.wait_type,
		ws.wait_time_ms,
		e.wait_description
	from sys.dm_os_wait_stats ws
	left join dbo.wait_stats_explained e
	on ws.wait_type = e.wait_type
	order by ws.wait_time_ms desc

go
