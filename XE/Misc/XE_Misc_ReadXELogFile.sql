/******************************************************************************
Author: Thomas Stringer
Created on: 4/18/2012

Description:
	this query reads an extended events log file
******************************************************************************/

-- use '*' for the wildcard char
declare @xepath nvarchar(128) = 'C:\databasefiles\extendedevents\slowstmts\slowstmts*.xel'

select *
from sys.fn_xe_file_target_read_file
(
	@xepath,
	null,
	null,
	null
)