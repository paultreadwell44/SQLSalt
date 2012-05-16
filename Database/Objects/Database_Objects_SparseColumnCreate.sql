/********************************************************************
Author: Thomas Stringer
Created on: 5/15/2012 

Description:
	shows an example of how to use a SPARSE column

Notes:
	- change 'YourDatabase' to the database where the table will be 
	created

	- this CREATE TABLE is to show an example only.  Modify according 
	to your particular environment and needs
********************************************************************/

use YourDatabase;
go

create table MySparseTable
(
	id int identity(1, 1) not null,
	SomeString nvarchar(128) sparse null
);
go