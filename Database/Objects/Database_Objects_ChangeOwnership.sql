/**********************************************************
Author: Thomas Stringer
Created on: 5/10/2012

Description:
	this command changes the owner of a particular object

Notes:
	- change 'YourDatabase' to the owning db

	- change 'YourObject' to the object you want to change 
	ownership for

	- change YourPrincipal to the new owning principal, or 
	SCHEMA OWNER to set as the owner of the schema
**********************************************************/

use YourDatabase
go

alter authorization
on YourObject
to YourPrincipal
go
