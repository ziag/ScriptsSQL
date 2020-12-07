BEGIN TRAN

SELECT
    bs.database_name,
    bs.backup_start_date,
    bmf.physical_device_name
FROM
    msdb.dbo.backupmediafamily bmf
    JOIN
    msdb.dbo.backupset bs ON bs.media_set_id = bmf.media_set_id
WHERE
    bs.database_name = 'UDA_RH'
ORDER BY
    bmf.media_set_id DESC;


	SELECT d.name as [DBname]
, [hoursSinceFull] = max(isnull(datediff(hour,b.backup_start_date,getdate()),-1)) 
, [hoursSinceDiff] = max(isnull(datediff(hour,bi.backup_start_date,getdate()),-1))
FROM [master].[sys].[databases] d with (nolock)
LEFT JOIN [msdb]..[backupset] b  with (nolock) on d.name = b.database_name
and b.backup_start_date = (select max(backup_start_date)
from [msdb]..[backupset] b2
where b.database_name = b2.database_name and b2.type = 'D')
LEFT JOIN [msdb]..[backupset] bi  with (nolock) on d.name = bi.database_name
and bi.backup_start_date = (select max(backup_start_date)
from [msdb]..[backupset] b3
where bi.database_name = b3.database_name and b3.type = 'I')
where d.name <> 'UDA_RH' 
and d.state = 0 
and d.source_database_id is null  
group by d.name
ROLLBACK