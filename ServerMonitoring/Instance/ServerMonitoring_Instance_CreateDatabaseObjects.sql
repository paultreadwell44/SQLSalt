use DBA;
go

create table dbo.db
(
	database_id int identity(1, 1) not null
		primary key clustered,
	server_id int not null
		foreign key references dbo.server(server_id),
	name nvarchar(128) not null,
	recovery_model nvarchar(60) null,
	state nvarchar(60) null
);
go