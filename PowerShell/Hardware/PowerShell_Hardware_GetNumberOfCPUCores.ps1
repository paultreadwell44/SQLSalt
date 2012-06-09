# ===================================================================
# Author: Thomas Stringer
# Created on: 6/8/2012
#
# Description: this script retrieves the number of corse on the 
#	current machine
# ===================================================================

Get-WmiObject -Class Win32_Processor |
	Select-Object NumberOfCores |
	Format-Table -AutoSize