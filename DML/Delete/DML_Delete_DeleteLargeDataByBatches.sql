/********************************************************************
Author: Thomas Stringer
Created on: 5/8/2012

Description:
	a demonstration on how to delete a large amount of data by 
	using batch deleting in order to minimize contention and maximize 
	concurrency

Notes:
	- change 'YourDatabase' to the database containin the table

	- change 'YourTable' to the table to delete from

	- set @batch_size to the desire amount of rows to delete per 
	batch

	- modify the DELETE FROM statement for your specific application 
	to include a WHERE clause if it is necessary
********************************************************************/

use YourDatabase
go

declare 
	@batch_size int,
	@del_rowcount int = 1

set @batch_size = 100

set nocount on;

while @del_rowcount > 0
	begin
		begin tran
			delete top (@batch_size)
			from YourTable

			set @del_rowcount = @@rowcount
			print 'Delete row count: ' + cast(@del_rowcount as nvarchar(32))
		commit tran
	end