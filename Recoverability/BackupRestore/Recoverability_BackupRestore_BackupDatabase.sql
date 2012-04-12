/**********************************************************
Author: Thomas Stringer
Created on: 4/11/2012

Description:
	simple backup statement

Notes:
	change 'YourDatabase' to the database you desire to 
	backup
**********************************************************/
use master
go

backup database YourDatabase
to disk = 'C:\YourDir\YourBackupName.bak'
with
	stats = 5
go