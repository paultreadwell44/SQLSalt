/********************************************************************
Author: Thomas Stringer
Created on: 4/27/2012

Description:
	creates a new server registered server in the specified server 
	group

Notes:
	- set @server_group_name to an existing server group name

	- set @server_instance_name to the server name with instance (if 
	not the default instance)

	- set @new_server_name to the desired registered server name
********************************************************************/

declare 
	@server_group_name sysname = 'YourServerGroup',
	@server_instance_name sysname = 'YourServer\YourInstance',
	@new_server_name sysname = 'YourRegisteredServerName',
	@server_group_id int,
	@new_srv_id int

select
	@server_group_id = server_group_id
from msdb.dbo.sysmanagement_shared_server_groups
where name = @server_group_name

if @server_group_id is not null
	begin
		exec msdb.dbo.sp_sysmanagement_add_shared_registered_server
			@name = @new_server_name,
			@server_group_id = @server_group_id,
			@server_name = @server_instance_name,
			@server_type = 0,
			@server_id = @new_srv_id output
		select @new_srv_id as new_server_id		
	end
else
	begin
		raiserror('Server Group not found.  Verify the specified Server Group exists', 16, 1)
	end