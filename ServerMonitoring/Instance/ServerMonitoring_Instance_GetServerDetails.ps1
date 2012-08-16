param (
	[Parameter(Mandatory = $true)][string] $monI,
	[Parameter(Mandatory = $true)][string] $monD
)

[Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null

$mServer = New-Object Microsoft.SqlServer.Management.Smo.Server($monI)
$mDb = $mServer.Databases["DBA"]

$resultSet = $mDb.ExecuteWithResults("exec dbo.get_server_list")

foreach ($server in $resultSet.Tables[0]) {
	#insert data to table
	try {
		$serverTarget = New-Object Microsoft.SqlServer.Management.Smo.Server($server.server_name)
		if ($serverTarget.Status -eq $null) {
			throw
		}
		# insert server details to table via add_server_details stored proc
		$mDb.ExecuteNonQuery("
			exec dbo.add_server_details 
				$($server.server_id), 
				'$($serverTarget.Version)',
				'$($serverTarget.NetName)',
				'$($serverTarget.InstanceName)',
				'$($serverTarget.Edition)'"
		)
	}
	catch {
		# if there is an error, log it
		$mDb.ExecuteNonQuery("
			exec dbo.error_insert
				$($server.server_id),
				'Server not found: $($server.server_name)'"
		)
	}
}