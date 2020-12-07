BEGIN TRAN

 
DECLARE @obj_name AS sysname, @obj_type AS sysname

DECLARE obj_cursor CURSOR FOR 
    SELECT SCHEMA_NAME(o.schema_id) + '.' + o.name, o.type_desc 
    FROM sys.objects o 
    INNER JOIN sys.sql_modules m 
		ON o.object_id = m.object_id

    WHERE o.is_ms_shipped = 0 
		AND m.is_schema_bound = 0 
		--  and o.name not like 'DELETE%'
    ORDER BY o.type_desc, SCHEMA_NAME(o.schema_id), o.name

OPEN obj_cursor 
FETCH NEXT FROM obj_cursor INTO @obj_name, @obj_type

WHILE (@@FETCH_STATUS <> -1) 
BEGIN
    BEGIN TRY
        EXEC sp_refreshsqlmodule @obj_name
        PRINT 'Refreshing ''' + @obj_name + ''' completed'
    END TRY
    BEGIN CATCH
        PRINT 'ERROR - ' + @obj_type + ' ''' + @obj_name + ''':' + ERROR_MESSAGE()
    END CATCH
    FETCH NEXT FROM obj_cursor INTO @obj_name, @obj_type
END 

CLOSE obj_cursor
DEALLOCATE obj_cursor 

 SELECT 'BEGIN TRAN T1;' UNION
    SELECT   REPLACE('BEGIN TRY
							EXEC sp_refreshsqlmodule ''{OBJECT_NAME}''
					  END TRY
					  
					  BEGIN CATCH
							PRINT ''{OBJECT_NAME} IS INVALID.'' 
							PRINT ERROR_MESSAGE()
							END CATCH', '{OBJECT_NAME}', QUOTENAME(ROUTINE_SCHEMA) + '.' + QUOTENAME(ROUTINE_NAME)

					 )
		 
    FROM    INFORMATION_SCHEMA.ROUTINES

    WHERE   OBJECTPROPERTY(OBJECT_ID(QUOTENAME(ROUTINE_SCHEMA) + '.' + QUOTENAME(ROUTINE_NAME)), N'IsSchemaBound') IS NULL
         OR OBJECTPROPERTY(OBJECT_ID(QUOTENAME(ROUTINE_SCHEMA) + '.' + QUOTENAME(ROUTINE_NAME)), N'IsSchemaBound') = 0
         
	UNION 
SELECT  'ROLLBACK TRAN T1;'
 
	
							/*
BEGIN 
	TRY      
		EXEC sp_refreshsqlmodule '[dbo].[sp_FetchPermis]'        
	END TRY        
BEGIN CATCH      PRINT '[dbo].[sp_FetchPermis] IS INVALID.'        END CATCH

*/

ROLLBACK