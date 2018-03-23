BEGIN TRAN


SELECT sj.name
      ,MAX( sja.last_executed_step_date ) lastDate 
   
FROM msdb.dbo.sysjobactivity AS sja

INNER JOIN msdb.dbo.sysjobs AS sj 
	ON sja.job_id = sj.job_id

WHERE sja.start_execution_date IS NOT NULL
 
GROUP BY sj.name

ORDER BY  MAX( sja.last_executed_step_date ) DESC



ROLLBACK