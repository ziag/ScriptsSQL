/*


*/

SELECT  statement AS [database.scheme.table],
column_id , column_name, column_usage, 
migs.user_seeks, migs.user_scans, 
migs.last_user_seek, migs.avg_total_user_cost,
migs.avg_user_impact

FROM sys.dm_db_missing_index_details AS mid
CROSS APPLY sys.dm_db_missing_index_columns (mid.index_handle)
INNER JOIN sys.dm_db_missing_index_groups AS mig ON mig.index_handle = mid.index_handle
INNER JOIN sys.dm_db_missing_index_group_stats  AS migs ON mig.index_group_handle=migs.group_handle

 
ORDER BY [database.scheme.table], migs.user_seeks desc, mig.index_group_handle, mig.index_handle, column_id


 