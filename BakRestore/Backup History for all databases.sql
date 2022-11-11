BEGIN TRAN

--------------------------------------------------------------------------------- 
-- Database Backups for all databases For last 600 days
--------------------------------------------------------------------------------- 
SELECT  
   CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
   msdb.dbo.backupset.database_name,  
   msdb.dbo.backupset.backup_start_date,  
   msdb.dbo.backupset.backup_finish_date, 
   DATEDIFF(SECOND,msdb.dbo.backupset.backup_start_date,msdb.dbo.backupset.backup_finish_date) duration_seconds,
   msdb.dbo.backupset.expiration_date, 
        CASE WHEN backupset.type = 'D' THEN 'Full backup'
             WHEN backupset.type = 'I' THEN 'Differential'
             WHEN backupset.type = 'L' THEN 'Log'
             WHEN backupset.type = 'F' THEN 'File/Filegroup'
             WHEN backupset.type = 'G' THEN 'Differential file'
             WHEN backupset.type = 'P' THEN 'Partial'
             WHEN backupset.type = 'Q' THEN 'Differential partial'
             ELSE 'Unknown (' + backupset.type + ')'
        END AS [Backup Type],  
   msdb.dbo.backupset.backup_size,  
   msdb.dbo.backupmediafamily.logical_device_name,  
   msdb.dbo.backupmediafamily.physical_device_name,   
   msdb.dbo.backupset.name AS backupset_name, 
   msdb.dbo.backupset.description 
FROM   msdb.dbo.backupmediafamily  
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
WHERE  (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE() - 600)  
ORDER BY  
   msdb.dbo.backupset.database_name, 
   msdb.dbo.backupset.backup_finish_date


SELECT  d.NAME, MAX(B.backup_finish_date) AS last_backup_finish_date
FROM    MASTER.sys.databases d WITH (NOLOCK)
LEFT OUTER JOIN msdb.dbo.backupset b WITH (NOLOCK) ON d.name = b.database_name AND b.type = 'D'
WHERE d.name <> 'tempdb'
GROUP BY d.name
ORDER BY 2



ROLLBACK