--SELECT @@SERVERNAME;

WITH fs
AS
(
    SELECT database_id, TYPE, SIZE * 8.0 / 1024 as SIZE   
    FROM sys.master_files
)
SELECT 
	@@SERVERNAME AS Serveur, 
    name as DbName,
    (SELECT SUM(SIZE) FROM fs WHERE TYPE = 0 AND fs.database_id = db.database_id) + -- DataFileSizeMB,
	--(SELECT SUM(SIZE)/1024 FROM fs WHERE TYPE = 0 AND fs.database_id = db.database_id) DataFileSizeGo,
    (SELECT SUM(SIZE) FROM fs WHERE TYPE = 1 AND fs.database_id = db.database_id) DbSizeMB
	,tailleBK.BackupSizeMb

FROM sys.databases db

INNER JOIN (

SELECT bckup.database_name, bckup.backup_size/ (1024*1024) AS BackupSizeMb FROM msdb.dbo.backupset AS bckup
INNER JOIN (

SELECT database_name, MAX(backup_finish_date) AS last_backup_date
FROM msdb.dbo.backupset
GROUP BY database_name) AS datBak
	ON bckup.database_name = datBak.database_name 
	AND bckup.backup_finish_date = datBak.last_backup_date
	) AS tailleBK 
	ON tailleBK.database_name = db.name
	 
 
  

--WITH LastBackUp AS (
   SELECT  bs.*
		--bs.database_name, 
   --    SUM(bs.backup_size) AS backup_size,
   --    CAST(bs.backup_start_date AS DATE) AS backup_start_date,
       --bmf.physical_device_name,
   --    Position = ROW_NUMBER() OVER (PARTITION BY bs.database_name ORDER BY bs.backup_start_date DESC)
FROM msdb.dbo.backupmediafamily bmf
    JOIN msdb.dbo.backupmediaset bms
        ON bmf.media_set_id = bms.media_set_id
    JOIN msdb.dbo.backupset bs
        ON bms.media_set_id = bs.media_set_id
    --WHERE bs.[type] = 'L'
--)
--SELECT LastBackUp.database_name, SUM(LastBackUp.backup_size)/(1024*1024) AS [Taille totale du dernier backup avec les logs]
--FROM LastBackUp
--WHERE LastBackUp.Position = 1
--GROUP BY LastBackUp.database_name;

WHERE bs.database_name = 'LARA'
AND bs.backup_finish_date > GETDATE()-1