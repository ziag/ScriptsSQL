 
	
USE [msdb]
GO



SET NOCOUNT ON

DECLARE  @name nvarchar(50)

declare @job nvarchar(50)
declare @path nvarchar(max) 

DECLARE db_cursor CURSOR FOR 

select   name from sys.databases
where database_id > 8 or database_id  = 7
order by database_id 

OPEN db_cursor

FETCH NEXT FROM db_cursor 
INTO @name

WHILE @@FETCH_STATUS = 0
begin

	set @job = 'Path_' + @name
	print 'job ' + @job
	set @path = '\\UDA-DC\D$\\BCK_SQL_UDANET\Main\BackUp_' + @name + '.bak'

/*	
EXEC master.dbo.sp_dropdevice @logicalname = @job
	print  @job
-- Get the next vendor.
*/

	 EXEC master.dbo.sp_addumpdevice  @devtype = N'disk'
	, @logicalname = @job
	, @physicalname = @path
 

FETCH NEXT FROM db_cursor 
INTO @name



END 
CLOSE db_cursor
DEALLOCATE db_cursor


/*
/****** Objet :  Job [mp_Bak_Full.Subplan_1]    Date de génération du script : 03/19/2008 13:02:07 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Objet :  JobCategory [Database Maintenance]    Date de génération du script : 03/19/2008 13:02:07 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
declare @jobname varchar(max)
set @jobname = 'mp_Bak_Full_' + @name
 --N'mp_Bak_Full.Subplan_1', 
--EXEC @ReturnCode =  

print 'jobid av== ' + cast(@jobId as varchar(16))
exec	msdb.dbo.sp_add_job @job_name = @jobname,
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Pas de description disponible.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'UDA\shuard', @job_id = @jobId OUTPUT


print 'jobid == ' + cast(@jobId as varchar(16))

IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Objet :  Step [Subplan_1]    Date de génération du script : 03/19/2008 13:02:08 ******/--N'Subplan_1', 

declare @CommandLine varchar(max)
declare @MP_NAME varchar(max) 

set @MP_NAME = 'mp_Bak_Full_' + @name 
set @CommandLine = N'/Server "$(ESCAPE_NONE(SRVR))" /SQL "Maintenance Plans\' + @MP_NAME + '" /set "\Package\Subplan_1.Disable;false"'

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name= @name,
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command= @CommandLine, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

declare @time as int 
declare @timeadd as int 
set @timeadd = @timeadd + 1
set @time = @timeadd 

--N'mp_Bak_Full.Subplan_1', 
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name= @MP_NAME,
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20080319, 
		@active_end_date=99991231, 
		@active_start_time=@time, 
		@active_end_time=235959



IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
 

GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	print 'erreur ' + @name
EndSave:
COMMIT TRANSACTION

FETCH NEXT FROM db_cursor 
INTO @name

EXEC master.dbo.sp_dropdevice @logicalname = @job
	print  @job
-- Get the next vendor.

END 
CLOSE db_cursor
DEALLOCATE db_cursor
*/

