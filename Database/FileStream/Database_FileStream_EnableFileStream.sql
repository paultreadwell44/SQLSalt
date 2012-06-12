/********************************************************************
Author: Thomas Stringer
Created on: 6/11/2012

Description:
	this code enables filestream for an instance and database

Notes:
	- FILESTREAM must also be enabled at the service level

	- change 'YourDatabase' to the desired database to enable 
	filestream for

	- change 'YourFsDirectory' to be the db filestream directory 
	in the instance's filestream share
********************************************************************/

exec sp_configure 'show advanced options', 1;
go
reconfigure;
go

-- retrieve current FS access level
exec sp_configure 'filestream access level';
go

-- set FS access level
-- (
--	0: disabled,
--	1: T-SQL,
--	2: T-SQL and Win32 streaming
-- )
exec sp_configure 'filestream access level', 2;
go
reconfigure;
go

alter database YourDatabase
set filestream
(
	directory_name = 'YourFsDirectory',
	non_transacted_access = full
);
go