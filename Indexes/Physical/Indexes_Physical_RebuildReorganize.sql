/**********************************************************
Author: Thomas Stringer
Created on: 5/14/2012

Description:
	these commands show the numerous ways to handle index 
	maintenance

Note:
	- they are not meant to all be run at the same time, 
	just to show the commands and syntax

	- change 'YourIndex' to the desired index name

	- change 'YourTable' to the owning table
**********************************************************/

-- index rebuild
alter index YourIndex
on YourTable
rebuild;
go

-- ONLINE index rebuild
alter index YourIndex
on YourTable
rebuild
with 
(
	online = on
);
go

-- index reorganize
alter index YourIndex
on YourTable
reorganize;
go