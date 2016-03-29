BEGIN TRAN

DBCC SQLPERF(LOGSPACE);
GO

/*

use UDA_SYNC
go
DBCC SHRINKFILE( [Sync_log] , 1)


use ArtistiPcPaiementHistory
go
DBCC SHRINKFILE( [ArtistiPcPaiementHistory_log] , 1)

use [salesforce backups]
go
DBCC SHRINKFILE( [salesforce backup_log] , 1)

DBCC SQLPERF(LOGSPACE);
GO

 

use UDA_SYNC
go
DBCC SHRINKFILE( [Sync_log] , 1)


use ArtistiPcPaiementHistory
go
DBCC SHRINKFILE( [ArtistiPcPaiementHistory_log] , 1)

use [salesforce backups]
go
DBCC SHRINKFILE( [salesforce backups_log] , 1)


use [salesforce backups PreMajDBAmp]
go
DBCC SHRINKFILE( [salesforce backups_log] , 1)


*/


BEGIN TRAN

DBCC SQLPERF(LOGSPACE);
GO

ROLLBACK