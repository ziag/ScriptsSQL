BEGIN TRAN


Use [master]
GO

DECLARE @dbname VARCHAR(50)   
DECLARE @statement NVARCHAR(max)

DECLARE db_cursor CURSOR 
LOCAL FAST_FORWARD
FOR  
--Status 48 (mirrored db)
SELECT name FROM MASTER.dbo.sysdatabases --WHERE STATUS NOT LIKE 48  ---AND name NOT IN ('uda_axiant')  

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @dbname  
WHILE @@FETCH_STATUS = 0  
BEGIN  

SELECT @statement = 'SELECT * FROM ['+@dbname+'].INFORMATION_SCHEMA.ROUTINES  WHERE [ROUTINE_NAME] LIKE ''%blitz%'''+';'
print @statement

-- EXEC sp_executesql @statement

FETCH NEXT FROM db_cursor INTO @dbname  
END  
CLOSE db_cursor  
DEALLOCATE db_cursor

ROLLBACK