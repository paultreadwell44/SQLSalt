# SQL Salt 
 _SQL Server Database Administration Code and Helpful Scripts_ 

***
## AdminMisc  
### DAC  
[`AdminMisc_DAC_ConnectToDAC.txt`](https://github.com/trstringer/SQLSalt/blob/master/AdminMisc/DAC/AdminMisc_DAC_ConnectToDAC.txt)  
[`AdminMisc_DAC_EnableRemoteDAC.sql`](https://github.com/trstringer/SQLSalt/blob/master/AdminMisc/DAC/AdminMisc_DAC_EnableRemoteDAC.sql)  
[`AdminMisc_DAC_GetDACPort.sql`](https://github.com/trstringer/SQLSalt/blob/master/AdminMisc/DAC/AdminMisc_DAC_GetDACPort.sql)  
## Database  
### Accessibility  
[`Database_Accessibility_MultiUserSingleUserRestrictedUser.sql`](https://github.com/trstringer/SQLSalt/blob/master/Database/Accessibility/Database_Accessibility_MultiUserSingleUserRestrictedUser.sql)  
[`Database_Accessibility_OnlineOfflineEmergency.sql`](https://github.com/trstringer/SQLSalt/blob/master/Database/Accessibility/Database_Accessibility_OnlineOfflineEmergency.sql)  
[`Database_Accessibility_ReadOnlyReadWrite.sql`](https://github.com/trstringer/SQLSalt/blob/master/Database/Accessibility/Database_Accessibility_ReadOnlyReadWrite.sql)  
[`Database_Accessibility_StateForAllDBs.sql`](https://github.com/trstringer/SQLSalt/blob/master/Database/Accessibility/Database_Accessibility_StateForAllDBs.sql)  
### Storage  
[`TableSpace_GetSpaceAndPagesByUserTable.sql`](https://github.com/trstringer/SQLSalt/blob/master/Database/Storage/TableSpace_GetSpaceAndPagesByUserTable.sql)  
[`TableSpace_GetSpaceAndPagesForAllUserTables.sql`](https://github.com/trstringer/SQLSalt/blob/master/Database/Storage/TableSpace_GetSpaceAndPagesForAllUserTables.sql)  
## DBMail  
### Setup  
[`DBMail_Setup_GmailForDBMail.txt`](https://github.com/trstringer/SQLSalt/blob/master/DBMail/Setup/DBMail_Setup_GmailForDBMail.txt)  
## Indexes  
### Heaps  
[`Indexes_Heaps_GetAllHeapsForDb.sql`](https://github.com/trstringer/SQLSalt/blob/master/Indexes/Heaps/Indexes_Heaps_GetAllHeapsForDb.sql)  
### Physical  
[`Indexes_GetIndexesByTable.sql`](https://github.com/trstringer/SQLSalt/blob/master/Indexes/Physical/Indexes_GetIndexesByTable.sql)  
[`Indexes_Physical_GetRowsAndSpacePerIndex.sql`](https://github.com/trstringer/SQLSalt/blob/master/Indexes/Physical/Indexes_Physical_GetRowsAndSpacePerIndex.sql)  
[`Indexes_Structure_GetIndexedColsForAllTables.sql`](https://github.com/trstringer/SQLSalt/blob/master/Indexes/Physical/Indexes_Structure_GetIndexedColsForAllTables.sql)  
[`IndexFragmentationThreshold.sql`](https://github.com/trstringer/SQLSalt/blob/master/Indexes/Physical/IndexFragmentationThreshold.sql)  
### Usage  
[`Indexes_Usage_GetUnusedIndexes.sql`](https://github.com/trstringer/SQLSalt/blob/master/Indexes/Usage/Indexes_Usage_GetUnusedIndexes.sql)  
## Instance  
### Connectivity  
[`Instance_Connectivity_CurrentConnectionInfoWithSqlText.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Connectivity/Instance_Connectivity_CurrentConnectionInfoWithSqlText.sql)  
### Databases  
[`Instance_Databases_GetLogFileConsumptionForAllDBs.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Databases/Instance_Databases_GetLogFileConsumptionForAllDBs.sql)  
[`RecoveryModel_GetNonFullRecoveryModelDBs.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Databases/RecoveryModel_GetNonFullRecoveryModelDBs.sql)  
### Storage  
[`BufferPool_DataCache_TotalSizeOfDataPages.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Storage/BufferPool_DataCache_TotalSizeOfDataPages.sql)  
[`BufferPool_PlanCache_ClearAdHocPlans.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Storage/BufferPool_PlanCache_ClearAdHocPlans.sql)  
[`BufferPool_PlanCache_ClearCache.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Storage/BufferPool_PlanCache_ClearCache.sql)  
[`BufferPool_PlanCache_CountsByObjType.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Storage/BufferPool_PlanCache_CountsByObjType.sql)  
[`BufferPool_PlanCache_RecompileProc.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Storage/BufferPool_PlanCache_RecompileProc.sql)  
[`BufferPool_PlanCache_StoredProcsForDB.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Storage/BufferPool_PlanCache_StoredProcsForDB.sql)  
### Waits  
[`WaitStatsExplained_1_CreateTable.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Waits/WaitStatsExplained_1_CreateTable.sql)  
[`WaitStatsExplained_2_CreateProc.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Waits/WaitStatsExplained_2_CreateProc.sql)  
[`WaitStats_CurrentUserWaits.sql`](https://github.com/trstringer/SQLSalt/blob/master/Instance/Waits/WaitStats_CurrentUserWaits.sql)  
## PBM  
### Conditions  
[`PBM_Conditions_GetUserCreatedConditions.sql`](https://github.com/trstringer/SQLSalt/blob/master/PBM/Conditions/PBM_Conditions_GetUserCreatedConditions.sql)  
### Facets  
[`PBM_Facets_PossibleEvaluationModesPerFacet.sql`](https://github.com/trstringer/SQLSalt/blob/master/PBM/Facets/PBM_Facets_PossibleEvaluationModesPerFacet.sql)  
## Recoverability  
### AttachDetach  
[`Recoverability_AttachDetach_AttachDbWithNoLogFile.sql`](https://github.com/trstringer/SQLSalt/blob/master/Recoverability/AttachDetach/Recoverability_AttachDetach_AttachDbWithNoLogFile.sql)  
### BackupRestore  
[`BackupRestore_TestBackupDatabaseFromBackupFile.sql`](https://github.com/trstringer/SQLSalt/blob/master/Recoverability/BackupRestore/BackupRestore_TestBackupDatabaseFromBackupFile.sql)  
[`Recoverability_BackupRestore_BackupDatabase.sql`](https://github.com/trstringer/SQLSalt/blob/master/Recoverability/BackupRestore/Recoverability_BackupRestore_BackupDatabase.sql)  
[`Recoverability_BackupRestore_RestoreDatabase.sql`](https://github.com/trstringer/SQLSalt/blob/master/Recoverability/BackupRestore/Recoverability_BackupRestore_RestoreDatabase.sql)  
### Corruption  
[`Recoverability_Corruption_CorruptNCI_FOR_TESTING_ONLY.sql`](https://github.com/trstringer/SQLSalt/blob/master/Recoverability/Corruption/Recoverability_Corruption_CorruptNCI_FOR_TESTING_ONLY.sql)  
## Security  
### Principals  
[`Security_Principals_GetInstanceLogins.sql`](https://github.com/trstringer/SQLSalt/blob/master/Security/Principals/Security_Principals_GetInstanceLogins.sql)  
### Triggers  
[`LogonTrigger_1_CreateLoginAdmissionTable.sql`](https://github.com/trstringer/SQLSalt/blob/master/Security/Triggers/LogonTrigger_1_CreateLoginAdmissionTable.sql)  
[`LogonTrigger_2_CreateAddLoginPermittedTimeStoredProcedure.sql`](https://github.com/trstringer/SQLSalt/blob/master/Security/Triggers/LogonTrigger_2_CreateAddLoginPermittedTimeStoredProcedure.sql)  
[`LogonTrigger_3_CreateLogonTrigger.sql`](https://github.com/trstringer/SQLSalt/blob/master/Security/Triggers/LogonTrigger_3_CreateLogonTrigger.sql)  
