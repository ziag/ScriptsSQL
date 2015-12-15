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