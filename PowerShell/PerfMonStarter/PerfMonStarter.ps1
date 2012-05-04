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
#
#	[-mach "remoteMachineName"]
#		[the name of the remote machine to create set on (optional)]
#
#	[-logloc "C:\SomeDir\my_log"]
#		[the path to the log file that will be created (optional)]

#	[-colname "my_collector"]
#		[new collector's name (optional)]

param
(
	[string]$mach,
	[string]$inf,
	[string]$logloc,
	[string]$colname
)


# <DEFAULTS>	[alter to environment specs]
$sampleInterval = 5
$defaultLogLocation = "C:\DefaultDir\Default_log"
# </DEFAULTS>


# check to see if input parameters were filled
if ($inf -eq "") {
	Write-Host "ERROR!!!  -inf must be set to counter file"
	exit 1
}

# if the machine name wasn't supplied, use local
if ($mach -eq "") {
	$mach = "localhost"
}

# if log location wasn't supplised, use default
if ($logloc -eq "") {
	$logloc = $defaultLogLocation
}

# if no collector name specified, generate one
if($colname -eq "") {
	$dataCollectorName = "pfs_" + [datetime]::Now.Ticks
}
else {
	$dataCollectorName = $colname
}
Write-Host "Collection Name: " $dataCollectorName
Write-Host

Write-Host "Log File location..."
Write-Host $logloc

# create the collection and start it
Write-Host
Write-Host "Attempting to create collector set..."
logman create counter $dataCollectorName -s $mach -v mmddhhmm -cf $inf -o $logloc -f csv -si $sampleInterval
Write-Host

Write-Host "Attempting to start collector set..."
logman start $dataCollectorName -s $mach