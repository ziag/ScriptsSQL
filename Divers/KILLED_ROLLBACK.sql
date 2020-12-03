kill 75
execute sp_who

SELECT spid
,kpid
,login_time
,last_batch
,status
,hostname
,nt_username
,loginame
,hostprocess
,cpu
,memusage
,physical_io
FROM sys.sysprocesses
WHERE cmd = 'KILLED/ROLLBACK'

DBCC INPUTBUFFER(75)