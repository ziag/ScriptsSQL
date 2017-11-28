USE [msdb];
DECLARE @job_name VARCHAR(100);
SET @job_name = N'mp_Full_All';

--irst, delete the logs for the plan

DELETE sysmaintplan_log
FROM sysmaintplan_subplans AS subplans INNER JOIN
sysjobs_view AS syjobs ON subplans.job_id = syjobs.job_id INNER JOIN
sysmaintplan_log ON subplans.subplan_id = sysmaintplan_log.subplan_id
WHERE (syjobs.name = @job_name);

--–delete the subplan

DELETE sysmaintplan_subplans
FROM sysmaintplan_subplans AS subplans INNER JOIN
sysjobs_view AS syjobs ON subplans.job_id = syjobs.job_id
WHERE (syjobs.name = @job_name);

--–delete the actual job (You can do the same thing through Management Studio (Enterprise Manager)

DELETE
FROM msdb.dbo.sysjobs_view WHERE name = @job_name;