BEGIN TRAN

truncate table sql_job_monitoring

--set identity_insert sql_job_monitoring ON
DBCC CHECKIDENT (sql_job_monitoring, reseed, 1)

 
 



insert into dbo.sql_job_monitoring(  jobName, maxDate, messageJob, historiqueInstanceId, runStatus) 

SELECT   jobName, maxDate, messageJob, historiqueInstanceId, runStatus
FROM    sql_job_monitoring_BAK
ORDER BY  maxdate

SELECT *
FROM    sql_job_monitoring
ROLLBACK