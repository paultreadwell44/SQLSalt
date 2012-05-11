/**********************************************************
Author: Thomas Stringer
Created on: 5/10/2012

Description:
	this query returns the owners of objects within the 
	specified database

Notes:
	- change 'YourDatabase' to the database in question

	- the WHERE clause is commented out, therefore 
	returning all objects in the database.  Uncomment this 
	clause and list the explicit names of objects that you 
	would like to check ownership of
**********************************************************/

use YourDatabase
go

select
	o.name,
	case o.principal_id
		when null then
			ps.name
		else po.name
	end as owner_principal
from sys.objects o
left join sys.schemas s
on o.schema_id = s.schema_id
left join sys.database_principals ps
on s.principal_id = ps.principal_id
left join sys.database_principals po
on po.principal_id = s.principal_id
--where o.name in
--(
--	'Table1',
--	'View1',
--	'Table2'
--)