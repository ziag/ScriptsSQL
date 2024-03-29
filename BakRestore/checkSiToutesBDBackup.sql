SELECT  d.NAME, MAX(B.backup_finish_date) AS last_backup_finish_date
FROM    MASTER.sys.databases d WITH (NOLOCK)
LEFT OUTER JOIN msdb.dbo.backupset b WITH (NOLOCK) ON d.name = b.database_name AND b.type = 'D'
WHERE d.name <> 'tempdb'
GROUP BY d.name
ORDER BY 2