
SELECT @@MAX_CONNECTIONS as [this many]

SELECT count(1) as [this many] FROM sys.dm_exec_sessions

select 
    count(1) as [connections], 
    count(case [status] when 'sleeping' then null else 1 end) as [active connections],
    db_name([dbid]) as [database name],
    [hostname], 
    [loginame],
    [program_name]
from sys.sysprocesses
where [dbid] NOT IN (0)
group by [hostname], [loginame], [dbid], [program_name]
order by connections desc
