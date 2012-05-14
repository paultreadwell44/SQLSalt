/**********************************************************
Author: Thomas Stringer
Created on: 5/14/2012

Description:
	this query gets a summary of current locks in the 
	instance
**********************************************************/

select
	resource_type,
	resource_description,
	resource_associated_entity_id,
	request_mode,
	request_status
from sys.dm_tran_locks;