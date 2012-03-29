select *
from sys.dm_os_waiting_tasks
where session_id > 50