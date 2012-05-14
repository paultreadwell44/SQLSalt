/**********************************************************
Author: Thomas Stringer
Created on: 5/14/2012

Description:
	captures deadlock info to the error log

Notes:
	- the DBCC TRACEOFF command is commented out for 
	execution when use of trace flags 1204 and 3605 are 
	complete
**********************************************************/

dbcc traceon(1204, 3605, -1);
go

--dbcc traceoff(1204, 3605, -1);
--go