/******************************************************
Author: Thomas Stringer
Create Date: 4/4/2012

Description:
	set a database online, offline, or in emergency 
	state

Notes:
	replace 'YourDatabase' with your actual database 
	name
******************************************************/
use master
go

alter database YourDatabase
set online
go

-- take database immediately offline
-- rollback all transactions right away
alter database YourDatabase
set offline
with rollback immediate
go

-- take database offline when all open trans are 
--  committed or rolled back
-- rollback all transactions after 30 seconds
alter database YourDatabase
set offline
with rollback after 30
go

alter database YourDatabase
set emergency
with rollback immediate
go
