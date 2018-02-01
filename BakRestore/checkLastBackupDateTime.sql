BEGIN TRAN


--Script #1:  Return the LastBackupDateTime for each database on your Instance

SELECT db.Name AS DatabaseName,
COALESCE(CONVERT(VARCHAR(19), MAX(bs.backup_finish_date), 120),'None') AS LastBackUpDateTime
FROM sys.sysdatabases db
        LEFT OUTER JOIN msdb.dbo.backupset bs 
     ON bs.database_name = db.name
GROUP BY db.Name; 


--Script #2: Show the databases that have never had a backup, or the current backup is over 24 hours old

SELECT db.Name AS DatabaseName,
COALESCE(CONVERT(VARCHAR(19), MAX(bs.backup_finish_date), 120),'None') AS LastBackUpTime
FROM sys.sysdatabases db
        LEFT OUTER JOIN msdb.dbo.backupset bs 
     ON bs.database_name = db.name
GROUP BY db.Name
HAVING max(bs.backup_finish_date) < dateadd(dd,-1,getdate())
    or max(bs.backup_finish_date) is NULL

ROLLBACK