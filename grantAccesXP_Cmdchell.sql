EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell', 1
GO
RECONFIGURE
GO


EXEC sp_xp_cmdshell_proxy_account [uda\nubik], 'iContrat2015'



USE master;
GO
CREATE USER [uda\nubik] FOR LOGIN [uda\nubik];
GRANT EXECUTE ON xp_cmdshell TO [uda\nubik];