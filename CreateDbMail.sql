
/*

USE msdb
GO

sdfgsdfgsfdgsdfgsdfg
sdfgsdfgsfdgsdfgsdfg
hjlhj
vvnmvncbcncnb

sdfgsdfgsfdgsdfgsdfg

EXEC sp_addrolemember 'DatabaseMailUserRole', 'UDA\sgagnon'

EXEC msdb.sys.sp_helprolemember 'DatabaseMailUserRole';

EXEC msdb.dbo.sysmail_help_principalprofile_sp;
EXEC msdb.dbo.sysmail_help_status_sp;

EXEC msdb.dbo.sysmail_start_sp;
EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'mail';
*/
 

EXEC sp_send_dbmail @profile_name='SQL_Mail_Administrator', 
			 @recipients='xxx@yahoo.com', 
			 @body='test message', 
			 @subject='Ignore this message'


