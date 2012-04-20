/********************************************************************
Author: Thomas Stringer
Created on: 4/19/2012

Description:
	create a database snapshot

Notes:
	- requires Enterprise Edition of SQL Server

	- replace 'YourDatabase' with source database
********************************************************************/

create database YourDatabase_SnapShot
on
(
	name = 'YourDatabase_Data',
	filename = 'C:\YourDbDir\YourDatabase.ss'
)
as snapshot of YourDatabase
go