
BACKUP LOG [Bouffe]
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\BKlog.bak'
WITH NOFORMAT,
     			INIT,
     			NAME = N'Bouffe-Log Backup',
     			SKIP,
     			NOREWIND,
     			NOUNLOAD,
     			COMPRESSION,
     			STATS = 10;
GO
DECLARE @backupSetId AS INT;
SELECT @backupSetId = position
FROM msdb..backupset
WHERE database_name = N'bouffe'
      			AND backup_set_id =
      		(
          		SELECT MAX(backup_set_id)
          		FROM msdb..backupset
          		WHERE database_name = N'bouffe'
      		);
IF @backupSetId IS NULL
BEGIN
RAISERROR(N'Verify failed. Backup information for database ''Bouffe'' not found.', 16, 1);
END;
RESTORE VERIFYONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\BKlog.bak'
WITH FILE = @backupSetId,
     		NOUNLOAD,
     		NOREWIND;
GO