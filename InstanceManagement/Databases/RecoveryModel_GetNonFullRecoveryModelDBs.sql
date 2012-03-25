use master
go

select 
	name, 
	recovery_model_desc
from sys.databases
where recovery_model <> 1