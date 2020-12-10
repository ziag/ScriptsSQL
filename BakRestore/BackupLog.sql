
BACKUP LOG [AdventureWorks2012]
TO  DISK = N'<filelocation, backup name>'
WITH NOFORMAT,
     			INIT,
     			NAME = N'AdventureWorks2012-Log Backup',
     			SKIP,
     			NOREWIND,
     			NOUNLOAD,
     			COMPRESSION,
     			STATS = 10;
GO
DECLARE @backupSetId AS INT;
SELECT @backupSetId = position
FROM msdb..backupset
WHERE database_name = N'AdventureWorks2012'
      			AND backup_set_id =
      		(
          		SELECT MAX(backup_set_id)
          		FROM msdb..backupset
          		WHERE database_name = N'AdventureWorks2012'
      		);
IF @backupSetId IS NULL
BEGIN
RAISERROR(N'Verify failed. Backup information for database ''AdventureWorks2012'' not found.', 16, 1);
END;
RESTORE VERIFYONLY
FROM DISK = N'<filelocation, backup name>'
WITH FILE = @backupSetId,
     		NOUNLOAD,
     		NOREWIND;
GO