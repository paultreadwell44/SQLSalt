/**********************************************************
Author: Thomas Stringer
Created on: 4/16/2012

Description:
	query to get SQL Server and Windows logins for the 
	instance
**********************************************************/
use master
go

select
	name,
	type_desc,
	is_disabled,
	default_database_name
from sys.server_principals
where type in ('u', 's')