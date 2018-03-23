USE msdb
GO

EXEC dbo.sp_help_jobhistory
    --@sql_message_id = 50100,
    --@sql_severity = 20,
    --@mode = N'FULL',
    --@job_name = N'' 
    @run_status = 0 ;
    
GO