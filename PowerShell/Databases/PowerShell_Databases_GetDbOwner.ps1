# ===================================================================
# Author: Thomas Stringer
# Created on: 7/1/2012
#
# Description:
#	this script will take a server and database as params and output 
#	the database owner to the host
#
# Notes:
#	* params *
#		-server : the server name and instance if not the default 
#			instance i.e. "MyServer\MyInstance"
#		-database : the database name to get the owner of
# ===================================================================

param (
	[string] $server,
	[string] $database
)

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") |
	Out-Null

$sql_server = New-Object ("Microsoft.SqlServer.Management.Smo.Server") $server
$db = $sql_server.Databases.Item($database)
$db_owner = $db.Owner

Write-Host "$database Owner: $db_owner"