use MeasureMySkills
go

declare @TableVariable1 table
(
	id int identity(1, 1) not null,
	SomeString nvarchar(100) not null
		default replicate('a', 100)
)

insert into @TableVariable1
values(default)

select *
from @TableVariable1