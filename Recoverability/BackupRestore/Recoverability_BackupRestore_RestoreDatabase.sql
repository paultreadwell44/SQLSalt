/************************************************
Author: Thomas Stringer
Created on: 4/12/2012

Description:
	simple restore command
************************************************/
use master
go

restore database YourDatabase
from disk = 'C:\YourBackupDir\YourBackup.bak'
with
	move 'YourDataFile' to 'C:\DataFileDir\YourDataFile.mdf',
	move 'YourLogFile' to 'C:\LogFileDir\YourLogFile.ldf',
	stats = 5
go