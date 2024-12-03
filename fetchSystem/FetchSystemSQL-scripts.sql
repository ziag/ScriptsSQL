
--Check the list of sysadmins and other server role members
SELECT  
  @@SERVERNAME 
, m.[name] as LoginName 
, r.[name] as RoleName
FROM sys.server_principals r 
  INNER JOIN sys.server_role_members rm ON r.principal_id = rm.role_principal_id 
  INNER JOIN sys.server_principals m ON m.principal_id = rm.member_principal_id
WHERE m.[name] NOT IN (N'sa',N'excpected account');






--Check DB Owners
SELECT
  DP1.[name] DatabaseRoleName 
, DP2.[name] DatabaseUserName   
FROM sys.database_principals DP1  
 INNER JOIN sys.database_role_members DRM ON DRM.role_principal_id = DP1.principal_id  
 INNER JOIN sys.database_principals DP2 ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.[type] = 'R'
  AND DP1.[name] = 'db_owner'
  AND DP2.[name] <> 'dbo'
ORDER BY DP1.[name];  



EXEC sp_MSforeachdb N'
SELECT
  ''?'' DBName
, DP1.[name] DatabaseRoleName 
, DP2.[name] DatabaseUserName   
FROM [?].sys.database_principals DP1  
 INNER JOIN [?].sys.database_role_members DRM  ON DRM.role_principal_id = DP1.principal_id  
 INNER JOIN [?].sys.database_principals DP2  ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.[type] = ''R''
  AND DP1.[name] = ''db_owner''
  AND DP2.[name] <> ''dbo''
ORDER BY DP1.[name]'   


--Settings changes
--This is one you really should probably do more often.
exec sp_configure 'fill factor (%)', 90; RECONFIGURE;

exec xp_readerrorlog 0, 1, N'Configuration option';


--GO BACK

---------------Cleanup Operations--------------
--Send a test email from every server.
SELECT * FROM msdb.dbo.sysmail_profile

exec msdb.dbo.sp_send_dbmail 
  @profile_name = 'From Query Above'
, @recipients = 'eric@mssqltips.com'
, @subject = 'test message';

https://www.mssqltips.com/sqlservertip/6383/sending-mail-messages-FROM-sql-server/


--Agent Job Owners
--An agent job owned by an AD account that is not AD will automatically fail. 
SELECT sj.[name], sp.[name] JobOwner 
FROM msdb.dbo.sysjobs sj
  INNER JOIN sys.server_principals sp ON sj.owner_sid = sp.[sid]
WHERE sp.[name] NOT IN (N'sa',N'excpected account');


--Database Ownership
SELECT d.[name] DBName, d.create_date, p.[name] PrincipalName
FROM sys.databases d
  LEFT OUTER JOIN sys.server_principals p ON d.owner_sid = p.[sid]
WHERE ISNULL(p.name, N'Uh Oh') NOT IN (N'sa',N'excpected account');


--Compatibility Modes
--Review compat modes of DBs when they are behind their server level.
DECLARE @TargetCompat TINYINT;
SELECT @TargetCompat = CAST(serverproperty('ProductMajorVersion') AS TINYINT) * 10

SELECT [name] DBName, [compatibility_level], @TargetCompat TargetCompat
FROM sys.databases
WHERE [compatibility_level] <> @TargetCompat;



--This should be enabled on every server.
EXEC xp_ReadErrorLog 
    0                   --Current Log 
, 1                   --SQL Log (2 for Agent) 
, N'database instant file'            --Search Term for Text column 
, N''
, NULL        --Start Time 
, NULL                --End Time 
, 'ASC';             --Sort order.


--Review log file sizes and VLF counts
--Target 1/3 log file to Data file.  
--Review any VLF count over a few hundred.
 
WITH TotalSizes AS (
  SELECT db_name(database_id) DBName
  , SUM(case when type_Desc = 'ROWS' THEN size ELSE 0 END)/128. DataSizeMB
  , SUM(case when type_Desc = 'LOG'  THEN size ELSE 0 END)/128. LogSizeMB
  FROM sys.master_files
  GROUP BY database_id)

, VLFCount AS (
  SELECT 
    s.[name]
  , COUNT(l.database_id) AS VLFCount
  FROM sys.databases s
    CROSS APPLY sys.dm_db_log_info(s.database_id) l
  GROUP BY s.[name])
 
SELECT DBName, DataSizeMB, LogSizeMB, CAST(ROUND(LogSizeMB/DataSizeMB*100, 0)AS INT) as PCT, VLFCount
FROM TotalSizes 
  INNER JOIN VLFCount ON TotalSizes.DBName = VLFCount.[name];


--GO BACK

--Are any certificates due to expire before the next checklist?
SELECT * FROM sys.certificates

SELECT
  d.name DBName
, dek.encryption_state_desc
, cer.name
FROM sys.certificates cer
  INNER JOIN sys.dm_database_encryption_keys dek  ON dek.encryptor_thumbprint = cer.thumbprint
  INNER JOIN sys.databases d ON dek.database_id = d.database_id;


CREATE CERTIFICATE A_NEW_ONE WITH SUBJECT = 'For a little while';
GO
USE WideWorldImporters
GO
ALTER DATABASE ENCRYPTION KEY 
  ENCRYPTION BY SERVER CERTIFICATE A_NEW_ONE;


--GO BACK

--Corruption

--Last successful checkdb
--SQL 2016+
SELECT DATABASEPROPERTYEX(N'WideWorldImporters', 'LastGoodCheckDbTime');



SELECT name, DATABASEPROPERTYEX (name , 'LastGoodCheckDbTime' )
FROM sys.databases
WHERE name <> 'tempdb'

--SQL 2014 and earlier
DBCC DBINFO('WideWorldImporters') WITH TABLERESULTS

--EXEC sp_MSforeachdb N'DBCC DBINFO(''?'') WITH TABLERESULTS;';

--Suspect Pages
--Review and clear all msdb.dbo.suspect_pages rows across the enterprise.
SELECT * FROM msdb.dbo.suspect_pages


--The type of error (event_type); one of:
--1 = An 823 error that causes a suspect page (such as a disk error) or an 824 error other than a bad checksum or a torn page (such as a bad page ID).
--2 = Bad checksum.
--3 = Torn page.
--4 = Restored (page was restored after it was marked bad).
--5 = Repaired (DBCC repaired the page).
--7 = Deallocated by DBCC.
 
--15 = dbid, 1 = file id, 1500 = page id.  
--All come from query above.
DBCC PAGE (15, 1, 1500, 0) WITH TABLERESULTS;

SELECT * FROM ReportServer.sys.objects 
WHERE object_id = 741577680;


--GO BACK


 ------SSRS Queries------------

--Beware linked reports and subreports
SELECT 'Report not executed in last 6 months', [Path] 
FROM ReportServer.dbo.[catalog] 
WHERE Type = 2 
  and ItemID NOT IN (SELECT ReportID 
                     FROM ReportServer.dbo.ExecutionLog 
                     WHERE TimeStart > GETDATE() - 180);




SELECT 
  ItemPath
, [Format]
, [TimeStart]
, [Status]
FROM ReportServer.dbo.executionlog3
WHERE RequestType = 'Subscription'
and timestart > getdate() - 60
and Status <> 'rsSuccess'
order by TimeStart;

SELECT 
  c.path
, s.Description
, s.LastStatus
, s.LastRunTime
FROM ReportServer.dbo.Subscriptions s
  INNER JOIN ReportServer.dbo.catalog c ON s.report_oid = c.itemid
WHERE LastStatus NOT LIKE 'mail sent to %'
AND LastStatus NOT LIKE 'done: % 0 errors.'
AND LastStatus <> 'Disabled'
AND s.LastRunTime > getdate() - 60;



