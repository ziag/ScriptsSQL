BEGIN TRAN

select t1.cntr_value As [Batch Requests/sec], 
    t2.cntr_value As [SQL Compilations/sec],
    plan_reuse = 
    convert(decimal(15,2),
    (t1.cntr_value*1.0-t2.cntr_value*1.0)/t1.cntr_value*100)
from 
    master.sys.dm_os_performance_counters t1,
    master.sys.dm_os_performance_counters t2
where 
    t1.counter_name='Batch Requests/sec' and
    t2.counter_name='SQL Compilations/sec'
    
    
   /*Compiled Plans: Ad-Hoc Queries vs. Stored Procedures*/ 
    WITH CACHE_STATS AS (
SELECT 
cast(SUM(case when Objtype ='Proc'  then 1 else 0 end) as DECIMAL (10,2)) as [Proc],
cast(SUM(case when Objtype ='AdHoc'  then 1 else 0 end) as DECIMAL (10,2)) as [Adhoc],
cast(SUM(case when Objtype ='Proc' 
      or Objtype ='AdHoc' then 1 else 0 end)as DECIMAL (10,2)) as [Total]
FROM sys.dm_exec_cached_plans 
WHERE cacheobjtype='Compiled Plan' 
)
 SELECT
 cast(Adhoc/Total as decimal (5,2)) * 100 as Adhoc_pct,
 cast([Proc]  /Total as decimal (5,2)) * 100 as Proc_Pct
 FROM CACHE_STATS c
 
 
 
 
 /*Single Use Ad-Hoc Queries in the cache*/
 SELECT TOP(50) [text] AS [QueryText], cp.size_in_bytes/1024/1024 as Size_IN_MB
FROM sys.dm_exec_cached_plans AS cp
CROSS APPLY sys.dm_exec_sql_text(plan_handle) 
WHERE cp.cacheobjtype = N'Compiled Plan' 
AND cp.objtype = N'Adhoc' 
AND cp.usecounts = 1
ORDER BY cp.size_in_bytes DESC OPTION (RECOMPILE);




WITH CACHE_ALLOC AS
(
SELECT  objtype AS [CacheType]
        ,COUNT_BIG(objtype) AS [Total Plans]
        , sum(cast(size_in_bytes as decimal(18,2)))/1024/1024 AS [Total MBs]
        , avg(usecounts) AS [Avg Use Count]
        , sum(cast((CASE WHEN usecounts = 1 THEN size_in_bytes ELSE 0 END) as decimal(18,2)))/1024/1024 AS [Total MBs - USE Count 1]
        , CASE 
      WHEN (Grouping(objtype)=1) THEN count_big(objtype)
      ELSE 0 
      END AS GTOTAL
          FROM sys.dm_exec_cached_plans
GROUP BY objtype 
) 
   SELECT
      [CacheType], [Total Plans],[Total MBs],
      [Avg Use Count],[Total MBs - USE Count 1],
      Cast([Total Plans]*1.0/Sum([Total Plans])OVER() * 100.0 AS DECIMAL(5, 2)) As Cache_Alloc_Pct
      FROM CACHE_ALLOC
      Order by [Total Plans] desc
 

/*Returning the batch text of cached entries that are reused*/
SELECT usecounts, cacheobjtype, objtype, text 
FROM sys.dm_exec_cached_plans 
CROSS APPLY sys.dm_exec_sql_text(plan_handle) 
WHERE usecounts > 1 
and text like '%stored_Proc_cursor%'
ORDER BY usecounts DESC;
GO
 
 
 


ROLLBACK