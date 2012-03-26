select 
	count(*) * 8 / 1024 as buffer_data_page_size_mb
from sys.dm_os_buffer_descriptors