param (
	[string] $serverName,
	[string] $databaseName,
	[string] $scriptDirectory
)
# ************************ GLOBALS ************************
#region globals
$schemaExclusions = "sys", "INFORMATION_SCHEMA"
$scriptingOptions = New-Object Microsoft.SqlServer.Management.Smo.ScriptingOptions
	$scriptingOptions.AnsiPadding = $false
	$scriptingOptions.IncludeHeaders = $true
	$scriptingOptions.NoCollation = $true
	$scriptingOptions.Indexes = $true
#endregion

# *********************** FUNCTIONS ***********************
#region functions

function Create-ScriptFile {
	param (
		[string] $subDirName,
		[string] $fileName,
		[string] $fileBody
	)
	
	if (!(Test-Path -Path $scriptDirectory\$subDirName)) {
		New-Item $scriptDirectory\$subDirName -ItemType Directory | Out-Null
	}
	
	$fileBody | Out-File -FilePath $scriptDirectory\$subDirName\$fileName -Force
}
function Script-AllTables {
	param (
		[Microsoft.SqlServer.Management.Smo.Database] $db
	)
		
	foreach ($table in $db.Tables) {
		$newFileName = $table.Schema + '.' + $table.Name + '.sql'
		Create-ScriptFile -subDirName 'Tables' -fileName $newFileName -fileBody $table.Script($scriptingOptions)
	}
}
function Script-AllViews {
	param (
		[Microsoft.SqlServer.Management.Smo.Database] $db
	)
	
	foreach ($view in $db.Views) {
		if (!($schemaExclusions -contains $view.Schema)) {
			$newFileName = $view.Schema + '.' + $view.Name + '.sql'
			Create-ScriptFile -subDirName 'Views' -fileName $newFileName -fileBody $view.Script($scriptingOptions)
		}
	}
}
function Script-AllProcs {
	param (
		[Microsoft.SqlServer.Management.Smo.Database] $db
	)
	
	foreach ($proc in $db.StoredProcedures) {
		if (!($schemaExclusions -contains $proc.Schema)) {
			$newFileName = $proc.Schema + '.' + $proc.Name + '.sql'
			Create-ScriptFile -subDirName 'StoredProcedures' -fileName $newFileName -fileBody $proc.Script($scriptingOptions)
		}
	}
}
function Script-AllFunctions {
	param (
		[Microsoft.SqlServer.Management.Smo.Database] $db
	)
	
	foreach ($udf in $db.UserDefinedFunctions) {
		if (!($schemaExclusions -contains $udf.Schema)) {
			$newFileName = $udf.Schema + '.' + $udf.Name + '.sql'
			Create-ScriptFile -subDirName 'Functions' -fileName $newFileName -fileBody $udf.Script($scriptingOptions)
		}
	}
}

#endregion

[Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null
$server = New-Object Microsoft.SqlServer.Management.Smo.Server($serverName)
$database = $server.Databases[$databaseName]

Script-AllTables $database
Script-AllViews $database
Script-AllProcs $database
Script-AllFunctions $database