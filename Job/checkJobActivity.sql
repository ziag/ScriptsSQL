BEGIN TRAN


SELECT sj.name
   , sja.*
FROM msdb.dbo.sysjobactivity AS sja
INNER JOIN msdb.dbo.sysjobs AS sj ON sja.job_id = sj.job_id
WHERE sja.start_execution_date IS NOT NULL
   AND sja.stop_execution_date IS NULL



DECLARE @currentSession AS INT
SELECT @currentSession = MAX(session_id)
FROM msdb.dbo.syssessions

SELECT count(*)
FROM msdb.dbo.sysjobactivity ja
JOIN msdb.dbo.sysjobs j
  ON j.job_id = ja.job_id
WHERE j.name = 'cdc.Audit_capture'
  AND session_id = @currentSession
  AND ja.run_requested_date IS NOT NULL
  AND ja.stop_execution_date IS NULL

ROLLBACK