/********************************************************************
Author: Thomas Stringer
Created on: 4/19/2012

Description:
	revert database from a snapshot

Notes:
	- requires Enterprise Edition of SQL Server

	- replace 'YourDatabase' with source database

	- replace 'YourDatabase_SnapShot' with source snapshot
********************************************************************/
use master
go

restore database YourDatabase
from database_snapshot = 'YourDatabase_SnapShot'
go