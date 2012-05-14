/**********************************************************
Author: Thomas Stringer
Created on: 5/14/2012

Description:
	this script contains two separate commands for 
	disabling lock escalation.  The first is on the table 
	level, and the second is with trace flags for instance 
	level.

Notes:
	use trace flag 1211 to disable lock escalation for 
	number of locks threshold (which 1224 does as well) 
	and memory pressure (which 1224 does not do)
**********************************************************/

alter table LockedTable
set
(
	lock_escalation = disable
);
go

dbcc traceon(1211); -- or 1224
go