BEGIN TRANSACTION;


SELECT
 DB_NAME() [database name]
,[schema name] = SCHEMA_NAME([schema_id])
,o.name
,ps.last_execution_time 
FROM   sys.dm_exec_procedure_stats ps 
INNER JOIN
       sys.objects o 
       ON ps.OBJECT_ID = o.OBJECT_ID 
WHERE o.TYPE = 'P'
-- AND o.SCHEMA_ID = SCHEMA_NAME(SCHEMA_ID)
-- AND o.name = 'uspMyFifthStoredProcedure'
ORDER BY
       ps.last_execution_time;


ROLLBACK;