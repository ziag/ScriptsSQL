BEGIN TRAN

SELECT  'USE ['+ nomDB.name + ']; ',
		'ALTER DATABASE ['+ nomDB.name + '] SET RECOVERY SIMPLE WITH NO_WAIT; ',
		'DBCC SHRINKFILE(['+  fichierLog.name + '] , 1); '
		
		
FROM sys.databases nomDB

INNER JOIN  sys.master_files AS fichierLog 
	ON nomDB.database_id = fichierLog.database_id

WHERE nomDB.name NOT IN ('master','tempdb','model','msdb','ReportServer','ReportServerTempDB')
AND recovery_model_desc = 'FULL' 
 
AND TYPE = 1  --fichier log


ROLLBACK