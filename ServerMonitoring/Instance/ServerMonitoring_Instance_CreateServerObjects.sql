use DBA;
go

-- ********** dbo.server CREATE TABLE **********
if exists 
(
	select 1 
	from sys.objects 
	where object_id = object_id('dbo.server')
)
	drop table dbo.server;
go
create table dbo.server
(
	server_id int identity(1, 1) not null
		primary key clustered,
	server_name nvarchar(512) not null,
	machine_name nvarchar(256) null,
	instance_name nvarchar(256) null,
	sqlserver_version nvarchar(16) null,
	edition nvarchar(128) null,
	created datetime null,
	last_updated datetime null
);
go

-- ********** dbo.server table trigger **********
if exists 
(
	select 1 
	from sys.triggers 
	where name = 'server_insert_update'
	and parent_id = object_id('dbo.server')
)
	drop trigger dbo.server_insert_update;
go
create trigger dbo.server_insert_update
on dbo.server
after insert, update
as
	-- test for an update operation by looking at the deleted tbl
	if exists (select * from deleted)
		begin
			-- only update the last_updated column if data has changed
			;with UpdateCte as
			(
				select *
				from deleted
				except
				select *
				from inserted
			)
			update dbo.server
			set last_updated = getdate()
			where server_id in
			(
				select server_id
				from UpdateCte
			);
		end
	-- otherwise it is just an insert
	else
		begin
			update dbo.server
			set 
				last_updated = getdate(),
				created = getdate()
			where server_id in
			(
				select server_id
				from inserted
			);
		end
go

-- -- ********** dbo.add_server CREATE PROC **********
if exists
(
	select 1
	from sys.sql_modules
	where object_id = object_id('dbo.add_server')
)
	drop procedure dbo.add_server;
go
create procedure dbo.add_server
	@server_name nvarchar(512),
	@server_id int output
as

	set nocount on;

	insert into dbo.server(server_name)
	values(upper(@server_name));

	set @server_id = scope_identity();

go

-- ************ stored proc to get list of servers *************
if exists
(
	select 1
	from sys.sql_modules
	where object_id = object_id('dbo.get_server_list')
)
	drop proc dbo.get_server_list;
go
create procedure dbo.get_server_list
as

	set nocount on;

	select 
		server_id,
		server_name
	from dbo.server;
go

-- ************** stored proc to get a particular server_id **********
if exists
(
	select 1
	from sys.sql_modules
	where object_id = object_id('dbo.get_server_id')
)
	drop proc dbo.get_server_id;
go
create procedure dbo.get_server_id
	@server_name nvarchar(512),
	@server_id int output
as

	set nocount on;

	select
		@server_id = server_id
	from dbo.server
	where server_name = @server_name;

go

-- *************** stored proc to insert data to server table *******
if exists
(
	select 1
	from sys.sql_modules
	where object_id = object_id('dbo.add_server_details')
)
	drop proc dbo.add_server_details;
go
create procedure dbo.add_server_details
	@server_id int,
	@version nvarchar(16),
	@machine_name nvarchar(256),
	@instance_name nvarchar(256),
	@edition nvarchar(128)
as

	update dbo.server
	set 
		sqlserver_version = @version,
		machine_name = @machine_name,
		instance_name = @instance_name,
		edition = @edition
	where server_id = @server_id;

go