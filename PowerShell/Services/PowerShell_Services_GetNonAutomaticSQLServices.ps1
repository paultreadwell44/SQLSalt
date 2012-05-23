# ===================================================================
# Author: Thomas Stringer
# Created on: 5/22/2012
#
# Description:
#	this script retrieves all SQL Server services that aren't set to 
#	start automatically
#
# Notes:
#	* parameters *
#		-m : (optional) machine name to retrieve service status from
# ===================================================================

param (
	[string]$m = "localhost"
)

Get-WmiObject -ComputerName $m -Class Win32_Service | 
	Where-Object {
		($_.Name -like "*SQL*") -and
		($_.StartMode -ne "auto")
	} |
	Select-Object Name, StartMode, State |
	Format-Table -AutoSize
