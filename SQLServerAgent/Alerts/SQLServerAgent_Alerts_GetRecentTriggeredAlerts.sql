/**********************************************************
Author: Thomas Stringer
Created on: 4/26/2012

Description:
	retrieves the most recently triggered alerts
**********************************************************/

select top 10
	name,
	event_category_id,
	event_id,
	message_id,
	severity,
	enabled,
	last_occurrence_date,
	last_occurrence_time
from msdb.dbo.sysalerts
order by 
	last_occurrence_date desc, 
	last_occurrence_time desc