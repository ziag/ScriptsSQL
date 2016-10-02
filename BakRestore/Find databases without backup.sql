DECLARE @dayswithout int = 1 -- Days without backup for activate send mail.

CREATE TABLE #tablenames (id int NOT NULL IDENTITY (1, 1),name nvarchar (50))

INSERT INTO #tablenames (name)  
SELECT DISTINCT msdb.dbo.backupset.database_name
FROM msdb.dbo.backupset 
WHERE msdb..backupset.type = 'd' 
and (CONVERT(datetime, msdb.dbo.backupset.backup_finish_date, 102) >= GETDATE() - @dayswithout)

DECLARE @numberddbbnobk int = 
( 
SELECT count (name) 
from sys.databases 
WHERE state_desc = 'ONLINE' and name <> 'tempdb' and name not in (select name from #tablenames)
)

DECLARE @subjectmail NVARCHAR (255) = 'There are '+ ( select convert (nvarchar(10), @numberddbbnobk))+' DDBB without backup in ' + (SELECT @@servername)
		
DECLARE @querymail nvarchar (900) = 'set nocount on;

SELECT @@servername [Server Information]
union ALL

SELECT DISTINCT dec.local_net_address 
FROM sys.dm_exec_connections AS dec
WHERE  dec.local_net_address IS NOT NULL 
union ALL

SELECT ''------------------'' 
union ALL

SELECT ''BBDD WITHOUT BACKUP''
union ALL

SELECT ''------------------''
union ALL

SELECT name  from sys.databases where name not in
(
SELECT DISTINCT
msdb.dbo.backupset.database_name
FROM msdb.dbo.backupset 
WHERE (CONVERT(datetime,msdb.dbo.backupset.backup_finish_date, 102) >= GETDATE() -'+ ( select convert (nvarchar(10), @dayswithout))+')) 
and state_desc = ''ONLINE'' and name <> ''tempdb'''
<pre>
</div>

</p>5-	If there is any bbdd <b> without backup </b> at the right time, we send an alert email mode.</p>
<div class="codediv">
<pre>
IF	@numberddbbnobk > 0

EXEC msdb.dbo.sp_send_dbmail  

@profile_name = 'Alert DBA', --Your profile name
@recipients = 'alertdba@mydomain.com', --Your alert´s mail address
@importance= 'High', 
@subject = @subjectmail, 
@body = 'Attach file with information about DDBB without backup.',
@query = @querymail,
@query_attachment_filename='DDBB_NO_BACKUP.csv', -- File with info about databases. 
@attach_query_result_as_file = 1 ;

DROP TABLE #tablenames
