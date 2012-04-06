/***********************************************************
Author: Thomas Stringer
Created on: 4/5/2012

Description:
	alter the database for user access for multi user, 
	single user, or restricted user mode
***********************************************************/
use master
go

alter database AdventureWorks2012
set multi_user
go

alter database AdventureWorks2012
set single_user
with rollback immediate
go

alter database AdventureWorks2012
set restricted_user
with rollback immediate
go