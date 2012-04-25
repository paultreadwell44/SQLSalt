/**********************************************************
Author: Thomas Stringer
Created on: 4/24/2012

Description:
	add a database user to a role

Notes:
	- change 'YourDatabase' to desired database

	- change 'YourRole' to the desired role for member

	- change 'YourUserOrRoleOrWinLoginOrWinGroup' to the 
	desired member to add to the role

	- this is for SQL Server 2012 
**********************************************************/

use YourDatabase
go

alter role YourRole
	add member YourUserOrRoleOrWinLoginOrWinGroup
go