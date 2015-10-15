EXECUTE sp_MSforeachdb 'if ''?'' NOT IN (''tempdb'',''master'',''model'',''msdb'', ''[salesforce backups]'') use ? exec sp_updatestats' 

EXECUTE sp_MSforeachdb 'if ''?'' IN ([salesforce backups]) use ? exec sp_updatestats' 

'[salesforce backups]'



DECLARE @cmd VARCHAR(MAX) 

set @cmd = 'SELECT  ''USE '' + QUOTENAME(db.name) + CHAR(13) + ''EXECUTE sp_updatestats;'' + CHAR(13) 
			FROM    sys.databases  AS db
			WHERE db.name NOT IN (''master'',''tempdb'',''model'',''msdb'',''ReportServer'',''ReportServerTempDB'')
			'
			
EXECUTE (@cmd) 



