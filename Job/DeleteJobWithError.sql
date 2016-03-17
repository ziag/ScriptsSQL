USE [msdb]
declare @job_name varchar(100)
set @job_name = N'mp_Full_All'

--irst, delete the logs for the plan

delete sysmaintplan_log
FROM sysmaintplan_subplans AS subplans INNER JOIN
sysjobs_view AS syjobs ON subplans.job_id = syjobs.job_id INNER JOIN
sysmaintplan_log ON subplans.subplan_id = sysmaintplan_log.subplan_id
WHERE (syjobs.name = @job_name)

--–delete the subplan

delete sysmaintplan_subplans
FROM sysmaintplan_subplans AS subplans INNER JOIN
sysjobs_view AS syjobs ON subplans.job_id = syjobs.job_id
WHERE (syjobs.name = @job_name)

--–delete the actual job (You can do the same thing through Management Studio (Enterprise Manager)

delete
from msdb.dbo.sysjobs_view where name = @job_name