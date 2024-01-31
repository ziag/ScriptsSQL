BEGIN TRAN;


--Script #1:  Return the LastBackupDateTime for each database on your Instance

SELECT @@SERVERNAME AS 'ServerName',
       db.name AS DatabaseName,
	   db.dbid,
       COALESCE(CONVERT(VARCHAR(19), MAX(bs.backup_finish_date), 120), 'None') AS LastBackUpDateTime,
       CASE bs.type
           WHEN 'D' THEN
               'Database'
           WHEN 'I' THEN
               'Differential database'
           WHEN 'L' THEN
               'Log'
           WHEN 'F' THEN
               'File or filegroup'
           WHEN 'G' THEN
               'Differential file'
           WHEN 'P' THEN
               'Partial'
           WHEN 'Q' THEN
               'Differential PARTIAL'
			ELSE ''
       END TypeBackUp,
		ISNULL(bs.recovery_model, '') AS RecoveryModel

FROM sys.sysdatabases AS db

LEFT OUTER JOIN msdb.dbo.backupset AS bs
    ON bs.database_name = db.name

GROUP BY db.name,
         bs.type,
         bs.recovery_model,
		 db.dbid

ORDER BY  db.dbid, db.name, bs.type


 

/*
SELECT
  t.object_id,
  OBJECT_NAME(t.object_id) ObjectName,
  sum(u.total_pages) * 8 Total_Reserved_kb,
  sum(u.used_pages) * 8 Used_Space_kb,
  u.type_desc,
  max(p.rows) RowsCount
FROM
  sys.allocation_units u
  JOIN sys.partitions p on u.container_id = p.hobt_id

  JOIN sys.tables t on p.object_id = t.object_id

GROUP BY
  t.object_id,
  OBJECT_NAME(t.object_id),
  u.type_desc
ORDER BY
  Used_Space_kb desc,
  ObjectName;
  */

ROLLBACK;