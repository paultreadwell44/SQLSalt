-- Description: result set of all database index fragmentation with a threshold percentage

declare 
	@DatabaseName nvarchar(128),
	@ThresholdPercentage int
	
/***** Parameter Initialization *****/
select
	@DatabaseName = N'AdventureWorks',
	@ThresholdPercentage = 30	
/*** END Parameter Initialization ***/

select *
from sys.dm_db_index_physical_stats
(
	db_id(@DatabaseName), 
	null, 
	null, 
	null, 
	null
)
where avg_fragmentation_in_percent >= @ThresholdPercentage