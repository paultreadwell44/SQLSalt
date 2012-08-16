use DBA;
go

-- ********** dbo.error CREATE TABLE **********
if exists 
(
	select 1 
	from sys.objects
	where object_id = object_id('dbo.error')
)
	drop table dbo.error;
go
create table dbo.error
(
	error_id int identity(1, 1) not null
		primary key clustered,
	server_id int not null,
	created datetime null,
	description nvarchar(1024) not null
);
go

-- ********** dbo.error_insert CREATE PROC **********
if exists
(
	select 1
	from sys.sql_modules
	where object_id = object_id('dbo.error_insert')
)
	drop proc dbo.error_insert;
go
create procedure dbo.error_insert
	@server_id int,
	@error_text nvarchar(1024)
as

	set nocount on;

	insert into dbo.error
	(
		server_id,
		created,
		description
	)
	values
	(
		@server_id,
		getdate(),
		@error_text
	);

go