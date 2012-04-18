/********************************************************************
Author: Thomas Stringer
Created on: 4/17/2012

Description:
	this query selects all user-created PBM conditions

Notes:
	- uncomment "-- and facet = 'SomeFacet'" to filter by facet

	- uncomment "-- and created_by = 'SomeLoginName'" to filter by
	the creating login
********************************************************************/

select
	name,
	created_by,
	date_created,
	modified_by,
	date_modified,
	facet
from msdb.dbo.syspolicy_conditions
where is_system = 0
-- and facet = 'SomeFacet'
-- and created_by = 'SomeLoginName'