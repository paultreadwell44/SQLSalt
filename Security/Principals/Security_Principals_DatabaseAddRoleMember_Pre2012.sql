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

	- this is for pre-2012 versions
**********************************************************/

use YourDatabase
go

exec sp_addrolemember
	@rolename = 'YourRole',
	@membername = 'YourUserOrRoleOrWinLoginOrWinGroup'
go