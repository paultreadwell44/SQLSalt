use MeasureMySkills
go

create table #TemporaryTable1
(
	id int identity(1, 1) not null,
	SomeString nvarchar(100) not null
		default replicate('a', 100)
)
go

create clustered index IX_TempTbl1
on #TemporaryTable1 (id)
go

insert into #TemporaryTable1
values(default)
go 101

select *
from #TemporaryTable1

select *
from tempdb.sys.tables
where name like '#TemporaryTable1%'