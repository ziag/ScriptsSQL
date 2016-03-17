
/*

USE msdb
GO

EXEC sp_addrolemember 'DatabaseMailUserRole', 'un user'

EXEC msdb.sys.sp_helprolemember 'DatabaseMailUserRole';

EXEC msdb.dbo.sysmail_help_principalprofile_sp;
EXEC msdb.dbo.sysmail_help_status_sp;

EXEC msdb.dbo.sysmail_start_sp;
EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'mail';

EXEC sp_send_dbmail @profile_name='Mail_Administrator', 
			 @recipients='xxx@yahoo.com', 
			 @body='test message', 
			 @subject='Ignore this message'

*/

-- Create a Database Mail account
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'SQL Administrator',
    @description = 'Mail account for administrative e-mail.',
    @email_address = 'administrator@sql.com',
    @replyto_address = 'noreply@sql.com',
    @display_name = 'SQL Automated Mailer',
    @mailserver_name = '192.168.10.10' ;

-- Create a Database Mail profile
EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'SQL Administrator Profile',
    @description = 'Profile used for administrative mail.' ;

-- Add the account to the profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'SQL Administrator Profile',
    @account_name = 'SQL Administrator',
    @sequence_number =1 ;

-- Grant access to the profile to the DBMailUsers role
--EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
--    @profile_name = 'SQL Administrator Profile',
--    @principal_name = 'ApplicationUser',
--    @is_default = 1 ;


