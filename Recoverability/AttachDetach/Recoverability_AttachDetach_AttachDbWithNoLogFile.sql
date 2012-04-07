/********************************************************
This T-SQL creates a database based off of attaching 
a single data file.

This is useful when you only have the primary data file.
********************************************************/
use master
go

create database YourDatabase
on
(
	filename = 'c:\ThePathToYourDataFile\YourDatabase.mdf'
)
for attach_rebuild_log
go