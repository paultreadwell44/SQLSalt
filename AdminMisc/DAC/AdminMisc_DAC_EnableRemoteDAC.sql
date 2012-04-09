/**********************************************************************
Author: Thomas Stringer
Created on: 4/9/2012

Description:
	this code sets the configuration option to allow DACs remotedly
**********************************************************************/

-- set 'remote admin connections' enabled
exec sp_configure 'remote admin connections', 1
go
reconfigure
go