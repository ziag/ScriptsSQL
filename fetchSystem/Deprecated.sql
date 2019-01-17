BEGIN TRAN

SELECT object_name, instance_name as
		deprecated_feature, cntr_value
FROM sys.dm_os_performance_counters

WHERE
	object_name like '%Deprecated%'
	and cntr_value > 0
ORDER BY  
	deprecated_feature

SELECT * FROM sys.configurations;


ROLLBACK