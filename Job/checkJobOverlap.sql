BEGIN TRANSACTION

/*
	shows jobs with overlapping runtime
	Wilfred van Dijk - wvand@wilfredvandijk.nl
		
	- minimum runtime: 5 minutes
	- only scheduled jobs are checked
	- only jobs from the last 7 days
*/
;WITH CTE AS (
	SELECT b.name AS job_name, a.start_execution_date, a.stop_execution_date, DATEDIFF(MINUTE, a.start_execution_date, a.stop_execution_date) AS run_time
	FROM msdb.dbo.sysjobactivity a
	JOIN msdb.dbo.sysjobs b
	ON a.job_id = b.job_id
	WHERE a.start_execution_date > DATEADD(dd, -7, GETDATE()) -- date criteria
	AND DATEDIFF(MINUTE, a.start_execution_date, a.stop_execution_date) > 5 -- runtime criteria
	AND a.run_requested_source = 1 -- scheduler only
)
SELECT a.job_name, a.start_execution_date, a.run_time, b.job_name, b.start_execution_date, b.run_time
FROM CTE a, CTE b
WHERE a.start_execution_date BETWEEN b.start_execution_date AND b.stop_execution_date
AND a.job_name <> b.job_name
AND (a.start_execution_date > b.start_execution_date OR a.stop_execution_date BETWEEN b.start_execution_date AND b.stop_execution_date)
;


ROLLBACK;