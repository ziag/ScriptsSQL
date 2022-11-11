BEGIN TRAN;


--Script #1:  Return the LastBackupDateTime for each database on your Instance

SELECT db.name AS DatabaseName,
       COALESCE(CONVERT(VARCHAR(19), MAX(bs.backup_finish_date), 120), 'None') AS LastBackUpDateTime
	   ,bs.*
FROM sys.sysdatabases db
    LEFT OUTER JOIN msdb.dbo.backupset bs
        ON bs.database_name = db.name
-- GROUP BY db.name;
SELECT * FROM  msdb.dbo.backupset bs

--Script #2: Show the databases that have never had a backup, or the current backup is over 24 hours old

SELECT db.name AS DatabaseName,
       COALESCE(CONVERT(VARCHAR(19), MAX(bs.backup_finish_date), 120), 'None') AS LastBackUpTime
FROM sys.sysdatabases db
    LEFT OUTER JOIN msdb.dbo.backupset bs
        ON bs.database_name = db.name
GROUP BY db.name
HAVING MAX(bs.backup_finish_date) < DATEADD(dd, -1, GETDATE())
       OR MAX(bs.backup_finish_date) IS NULL;

ROLLBACK;