-- allow changes to advanced options 
EXEC sp_configure 'show advanced options', 1
GO
-- Update currently configured values for advanced options.
RECONFIGURE
GO
-- To enable xp_cmdshell
EXEC sp_configure 'xp_cmdshell', 1
GO
-- Update currently configured values for advanced options.
RECONFIGURE
GO
EXEC xp_cmdshell 'NET USE V: \\uda-veeam\c$ passwordIci /USER:UDA\shuard'
GO

EXEC sp_configure 'xp_cmdshell', 0
GO
-- Update currently configured values for advanced options.
RECONFIGURE
GO


RESTORE DATABASE [Sigart] 
FROM  DISK = N'V:\BackupSQL\ARTISTI_SQL\Sigart\SIGART_backup_2017_04_03_220004_6046476.bak' 
WITH  FILE = 1,  
NOUNLOAD,  
REPLACE,  
STATS = 10

GO