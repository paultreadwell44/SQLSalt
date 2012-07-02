/********************************************************************
Author: Thomas Stringer
Created on: 6/28/2012

Description:
	this code will move the location of a database file

Notes:
	- change 'YourDatabase' to the database that owns the file to 
	move

	- change 'YourFile' to the logical file name of the file to move

	- change 'C:\YourDir\YourFileName.mdf' to the new path and file 
	name
********************************************************************/

alter database YourDatabase
set offline
with rollback immediate;
go

alter database YourDatabase
modify file
(
	name = 'YourFile',
	filename = 'C:\YourDir\YourFileName.mdf'
);

-- move the physical file to the new location

alter database YourDatabase
set online;
go