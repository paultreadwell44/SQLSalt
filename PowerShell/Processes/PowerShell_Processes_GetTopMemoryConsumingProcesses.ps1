# ===================================================================
# Author: Thomas Stringer
# Created on: 6/2/2012
#
# Description: this script gets the top 10 memory-consuming 
#	processes. Run this against servers that are running SQL Server 
#	and see what processes are taking up valuable resources
# ===================================================================
	
Get-WmiObject -Class Win32_Process |
	Sort-Object WorkingSetSize -Descending |
	Select-Object `
		Name, `
		WorkingSetSize, `
		@{Name = "WorkingSetSizeMB"; expression = {[Math]::Round($_.WorkingSetSize/(1024 * 1024), 1)}} `
		-First 10 |
	Format-Table -AutoSize