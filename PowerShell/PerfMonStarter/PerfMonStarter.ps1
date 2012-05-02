# Author: Thomas Stringer
# Created on: 5/1/2012
#
# Description:
#	This PowerShell script takes a text file as input and loads perfmon counters 
#	into a new data collector set.  Note, the text file should have a perfmon 
#	counter per line.
#
# Parameters
#	-inf "C:\SomeDir\my_counters.text" 
#		[the text file containing the perfmon counter list]
#	-logloc "C:\SomeDir\my_log"
#		[the path to the log file that will be created
#	-colname "my_collector"
#		[new collector's name (optional)]

param
(
	[string]$inf,
	[string]$logloc,
	[string]$colname
)

$perfmonCounters = Get-Content $inf

write-host "Loading Counters..."
$perfmonCounters + [Environment]::NewLine

Write-Host "Log File location..."
$logloc

if($colname -eq "")
{
	$dataCollectorName = "pfs_" + [datetime]::Now.Ticks
}
else
{
	$dataCollectorName = $colname
}
$dataCollectorName

Write-Host "Attempting to create counter..."
logman create counter $dataCollectorName -v mmddhhmm -c $perfmonCounters -o $logloc -f csv 
Write-Host "Success"
Write-Host

Write-Host "Attempting to start counter..."
logman start $dataCollectorName
Write-Host "Success"