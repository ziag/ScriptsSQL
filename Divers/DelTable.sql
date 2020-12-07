BEGIN TRAN

SELECT SCHEMA_NAME(o.schema_id) + '.' + o.name, o.type_desc 
FROM sys.objects o 
INNER JOIN sys.sql_modules m 
	ON o.object_id = m.object_id


SELECT 
    'ALTER TABLE [' +  OBJECT_SCHEMA_NAME(parent_object_id) +
    '].[' + OBJECT_NAME(parent_object_id) + 
    '] DROP CONSTRAINT [' + name + ']'
FROM sys.foreign_keys

  
SELECT  'Drop table '  + name 
FROM    sys.objects 
WHERE type_desc = 'USER_TABLE'


	/*
WHERE o.is_ms_shipped = 0 
	AND m.is_schema_bound = 0 
	and o.name not like 'DELETE%'
ORDER BY o.type_desc, SCHEMA_NAME(o.schema_id), o.name
*/
ROLLBACK