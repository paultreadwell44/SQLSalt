/********************************************************************
Author: Thomas Stringer
Created on: 4/17/2012

Description:
	gets possible evaluation modes for all facets
********************************************************************/

select
	name,
	'YES' as 'ON DEMAND',
	case execution_mode & 4
		when 4 then 'YES'
		else 'NO'
	end as 'ON SCHEDULE',
	case execution_mode & 2
		when 2 then 'YES'
		else 'NO'
	end as 'ON CHANGE (LOG)',
	case execution_mode & 1
		when 1 then 'YES'
		else 'NO'
	end as 'ON CHANGE (PREVENT)'
from msdb.dbo.syspolicy_management_facets