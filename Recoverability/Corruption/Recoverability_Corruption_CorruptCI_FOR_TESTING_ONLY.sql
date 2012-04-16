/***********************************************************************************
Author: Thomas Stringer
Created on: 4/12/2012

Description:
	this is a running script to work through in order to use a TEST database and 
	corrupt a nonclustered index.  This is for learning/training/testing/practicing 
	purposes.

Notes:
	1. DISCLAIMER: THIS IS FOR TESTING ONLY.  DO NOT UTILIZE THE BELOW OPERATIONS 
	IN PRODUCTION.

	2. I have used a copy of the Adventureworks2012 database to corrupt the NCI on 
	in order to test corruption, detection, and the fix.  For any other database 
	the testing steps would be the same, sans different table/indexes/etc.

	3. Work through the below code by clearly outlined sections.  Do NOT execute 
	this whole script as one.  It will not be successful.
***********************************************************************************/

/***********************************************************************************
***************************        SECTION 1       *********************************
***************************     CREATE DATABASE    *********************************
Notes:
	I have restored a copy of the Adventureworks2012 database and called it 
	'AdventureWorks2012_CorruptCI'.  This is going to be the database this test 
	uses to worked with corrupted data.
***********************************************************************************/
use AdventureWorks2012_CorruptCI
go

/***********************************************************************************
***************************        SECTION 2       *********************************
***************************  VIEW TABLE/INDEX DATA *********************************
Notes:
	Choose a table's nonclustered index as the victim
***********************************************************************************/
-- look at what kind of data is in the table
select *
from Person.EmailAddress


-- get the indexes for this table
declare @table_name as nvarchar(128) = 'EmailAddress'
select
	t.name as table_name,
	i.name as index_name,
	i.index_id,
	i.type_desc
from sys.indexes i
inner join sys.tables t
on i.object_id = t.object_id
where t.name = @table_name
order by i.index_id

-- the NCI we want to corrupt is IX_EmailAddress_EmailAddress (IndexID: 1)


/***********************************************************************************
***************************        SECTION 3       *********************************
***************************    INDEX PAGE VICTIM   *********************************
Notes:
	Get the index's page to corrupt, take db offline, and corrupt data in a hex 
	editor
***********************************************************************************/
-- retrieve all page data for the index IX_EmailAddress_EmailAddress (IndexID: 1)
dbcc ind('AdventureWorks2012_CorruptCI', 'person.emailaddress', 1)
go
-- page to corrupt - PagePID: 644 [PageFID: 1]
dbcc traceon(3604)
go
dbcc page('AdventureWorks2012_CorruptCI', 1, 644, 2)
go


-- get the page offset in the file
select 644 * 8192
-- page offset: 5275648

-- take AdventureWorks2012_CorruptCI OFFLINE
use master
go

alter database AdventureWorks2012_CorruptCI
set offline
with rollback immediate
go


-- locate the data file to corrupt
select
	name,
	physical_name
from sys.master_files
where database_id = db_id('AdventureWorks2012_CorruptCI')
and type = 0


-- load the file in a hex editor (I use XVI32 Hex Editor - it's a free download)

-- navigate to the page in the file by searching for the offset in the file
--		in XVI32: 
--			1. Address -> GoTo
--			2. Input the page offset (decimal)

-- zero out a byte to cause data corruption


/***********************************************************************************
***********************            SECTION 4             ***************************
***********************  SHOW DATA CORRUPTON AND REPAIR  ***************************
Notes:
	Get the index's page to corrupt, take db offline, and corrupt data in a hex 
	editor
***********************************************************************************/
-- put the database back ONLINE
use master
go

alter database AdventureWorks2012_CorruptCI
set online
go


-- prove the data corruption
use AdventureWorks2012_CorruptCI
go

select *
from Person.EmailAddress

-- should receive a similar error:
--	Msg 824, Level 24, State 2, Line 2
--	SQL Server detected a logical consistency-based I/O error: incorrect checksum (expected: 0x7a8bce03; actual: 0x7ab14e03).


-- run DBCC CHECKDB to view the issue
dbcc checkdb with no_infomsgs


-- use the partition_id in the DBCC CHECKDB error message to find the corrupted index
select
	p.partition_id,
	o.name as table_name,
	i.name as index_name,
	i.type_desc
from sys.partitions p
inner join sys.objects o
on o.object_id = p.object_id
inner join sys.indexes i
on o.object_id = i.object_id
and p.index_id = i.index_id
where partition_id = 72057594045071360

alter database AdventureWorks2012_CorruptCI
set multi_user
with rollback immediate
go
dbcc checkdb('AdventureWorks2012_CorruptCI', repair_allow_data_loss)
go

dbcc checkdb('AdventureWorks2012_CorruptCI') with no_infomsgs


-- the corrupted data is a NONCLUSTERED INDEX... drop and recreate it
-- but first let's find out what that index consisted of
select
	object_name(i.object_id) as table_name,
	i.name as index_name,
	i.type_desc,
	c.name as column_name,
	ic.is_included_column
from sys.indexes i
inner join sys.index_columns ic
on i.object_id = ic.object_id
and i.index_id = ic.index_id
inner join sys.objects o
on i.object_id = o.object_id
inner join sys.columns c
on c.object_id = i.object_id
and ic.column_id = c.column_id
where o.is_ms_shipped = 0
and i.name = 'ix_emailaddress_emailaddress'
order by table_name, i.type_desc, index_name


-- drop and recreate the NCI
drop index IX_EmailAddress_EmailAddress
on Person.EmailAddress
go

create index IX_EmailAddress_EmailAddress
on Person.EmailAddress(EmailAddress)
go


-- run DBCC CHECKDB to ensure the database is back to normal
dbcc checkdb with no_infomsgs