BEGIN TRAN

SELECT AVG(run_duration) run_duration_in_sec, COUNT(*) Numbers_of_Jobs

FROM msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobhistory h 
	ON j.job_id = h.job_id 
WHERE j.enabled = 1  --Only Enabled Jobs
AND  j.name='Sync DBAmp from SF' 
 
 
 ROLLBACK