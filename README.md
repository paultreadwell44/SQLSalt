# SQLSalt
_SQL Server Database Administration Code and Helpful Scripts_

***
## <font color="blue">Indexes</font>
### <font color="green">Physical</font>
`IndexFragmentationThreshold.sql`  _get indexes fragmented by a certain %_

## <font color="blue">Instance</font>
### <font color="green">Databases</font>
`RecoveryModel_GetNonFullRecoveryModelDBs.sql`  _retrieve non Full Recovery Model databases_  
### <font color="green">Storage</font>
`BufferPool_DataCache_TotalSizeOfDataPages.sql`  _get buffer pool data cache size_  
`BufferPool_PlanCache_CountsByObjType.sql`  _get buffer pool plan cache params by object type_  
### <font color="green">Waits</font>
`WaitStats_CurrentUserWaits.sql`  _get the current waits by user SPIDs_  
`WaitStatsExplained_1_CreateTable1.sql`  _create the base table for Wait Stats Explained_  
`WaitStatsExplained_2_CreateProc.sql`  _create the stored proc to get wait stats with descriptions_  

## <font color="blue">Recoverability</font>
### <font color="green">BackupRestore</font>
`BackupRestore_TestBackupDatabaseFromBackupFile.sql`  _create stored proc to test backups from a backup file_  

## <font color="blue">Security</font>
### <font color="green">Triggers</font>
`LogonTrigger_1_CreateLoginAdmissionTable.sql`  _create the base table to house login accessibility to instance_  
`LogonTrigger_2_CreateAddLoginPermittedTimedStoredProcedure.sql`  _create stored proc to add deny time to login admission/deny table_  
`LogonTrigger_3_CreateLogonTrigger.sql`  _create the logon trigger to check the deny table for login instance access_  