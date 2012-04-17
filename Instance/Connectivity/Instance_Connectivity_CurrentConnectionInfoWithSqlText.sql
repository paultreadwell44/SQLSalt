/********************************************************************
Author: Thomas Stringer
Created on: 4/16/2012

Description:
	this query gathers current connection-specific information to 
	the instance
********************************************************************/
use master
go

select
	c.session_id,
	s.login_name,
	c.client_net_address,
	c.client_tcp_port,
	c.connection_id,
	sq.text as most_recent_sql_text
from sys.dm_exec_connections c
cross apply sys.dm_exec_sql_text(c.most_recent_sql_handle) sq
inner join sys.dm_exec_sessions s
on c.session_id = s.session_id
order by c.session_id