/********************************************************************
Author: Thomas Stringer
Created on: 8/4/2012

Description:
	this script returns all current connections and the type of 
	endpoints the connections connect through
********************************************************************/
use master;
go

select 
	c.session_id,
	e.name as endpoint_name,
	e.protocol_desc,
	e.type_desc,
	c.connect_time
from sys.dm_exec_connections c
inner join sys.endpoints e
on c.endpoint_id = e.endpoint_id;