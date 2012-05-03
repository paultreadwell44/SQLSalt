/********************************************************************
Author: Thomas Stringer
Created on: 5/2/2012

Description:
	returns details about instance services including the machine 
	name, server\instance name, startup type, status, and service 
	account running under
********************************************************************/

select 
	@@servername as server_name,
	host_name() as host_name,
	servicename as service_name,
	startup_type_desc as startup,
	status_desc as status,
	service_account
from sys.dm_server_services