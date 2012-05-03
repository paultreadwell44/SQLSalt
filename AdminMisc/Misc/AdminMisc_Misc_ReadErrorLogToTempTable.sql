/**********************************************************
Author: Thomas Stringer
Created on: 5/2/2012

Description:
	this script creates a GLOBAL temp table and inserts 
	all of the contents of the active log into the temp 
	table for further querying

Notes:
	- the global temp table is named ##error_log
**********************************************************/

if exists
(
	select *
	from tempdb.sys.tables
	where name like '##error_log%'
)
	drop table ##error_log

create table ##error_log
(
	LogDate datetime not null,
	ProcessInfo nvarchar(128) not null,
	Text nvarchar(4000) not null
)
go

insert into ##error_log
exec master.sys.xp_readerrorlog

select *
from ##error_log

