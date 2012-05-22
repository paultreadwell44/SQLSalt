# ===================================================================
# Author: Thomas Stringer
# Created on: 5/21/2012
#
# Description: shows all SQL Server-related errors in the application 
#	event log.
#
# Params:
#	-m : (optional) the machine name to show stopped services of
# ===================================================================

param (
	[string]$m = "localhost"
)

Get-EventLog -LogName Application -ComputerName $m |
	Where-Object {($_.Source -like '*sql*') -and ($_.EntryType -eq "Error")} | 
	Select-Object -First 100 Time, Source, Message |
	Format-Table -AutoSize
	
Write-Host "Complete..."