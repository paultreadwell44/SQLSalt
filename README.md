SQL Salt
---------

_SQL Server Database Administration Scripts_

##Index

  * **IndexFragmentationThreshold.sql** : Location - \Indexes\ : script to select indexes that are fragmented beyond a particular percentage in a particular database

##Instance Management

  * **RecoveryModel_GetNonFullRecoveryModelDBs.sql** : Location - \InstanceManagement\Databases\ : a check on all databases that aren't in Full Recovery Model
  * **WaitStatsExplained_1_CreateTable.sql** : Location - \InstanceManagement\ : script to create base table for wait stats explained stored procedure
  * **WaitStatsExplained_2_CreateProc.sql** : Location - \InstanceManagement\ : script to create stored procedure to query sys.dm_os_wait_stats and correlate it with BOL explanations for wait stats

##Security

  * **LogonTrigger_1_CreateLoginAdmissionTable.sql** : Location - \Security\Triggers\ : creates the base table to store the logon times that particular logins will be permitted/denied
  * **LogonTrigger_2_CreateAddLoginPermittedTimeStoredProcedure.sql** : Location - \Security\Triggers\ : script to create the stored procedure to add a login deny entry into the admissions table
  * **LogonTrigger_3_CreateLogonTrigger.sql** : Location - \Security\Triggers\ : creates the logon trigger to get the current connection parameters and compare them to a potential deny in the admissions table