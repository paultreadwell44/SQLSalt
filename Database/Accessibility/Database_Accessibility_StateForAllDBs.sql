/**************************************************************
Author: Thomas Stringer
Created On: 4/4/2012

Description:
	gets a list of databases and their current state
**************************************************************/
use master
go

select
	name,
	state_desc
from sys.databases