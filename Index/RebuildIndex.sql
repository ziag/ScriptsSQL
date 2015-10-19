

DECLARE @Database VARCHAR(255)  
DECLARE @Table VARCHAR(255) 
DECLARE @cmd NVARCHAR(500) 
DECLARE @fillfactor INT


 
SET @fillfactor = 90

DECLARE DatabaseCursor CURSOR FOR 
SELECT name FROM master.dbo.sysdatabases  
WHERE name NOT IN ('master','model','msdb','tempdb')  
--WHERE name   IN  ('SIGART')  -- ('UDA_AXIANT','UDA_Membership') --('SIGART_TEST')  
ORDER BY 1 

OPEN DatabaseCursor 

FETCH NEXT FROM DatabaseCursor INTO @Database 
WHILE @@FETCH_STATUS = 0 
BEGIN 

   SET @cmd = 'DECLARE TableCursor CURSOR FOR SELECT table_catalog + ''.'' + table_schema + ''.'' +
              table_name as tableName FROM ' + @Database + '.INFORMATION_SCHEMA.TABLES
              WHERE table_type = ''BASE TABLE'''  

   -- create table cursor 
   EXEC (@cmd) 
   OPEN TableCursor  

   FETCH NEXT FROM TableCursor INTO @Table  
   WHILE @@FETCH_STATUS = 0  
   BEGIN  

     
       SET @cmd = 'ALTER INDEX ALL ON ' + @Table + ' REBUILD WITH (FILLFACTOR = ' +  CONVERT(VARCHAR(3),@fillfactor) + ')' 
       
       --SET @cmd = 'ALTER INDEX ALL ON ' + @Table + ' REORGANIZE' -- WITH (FILLFACTOR = ' +  CONVERT(VARCHAR(3),@fillfactor) + ')' 
 
       EXEC (@cmd) 

       FETCH NEXT FROM TableCursor INTO @Table  
   END  

   CLOSE TableCursor  
   DEALLOCATE TableCursor 

   FETCH NEXT FROM DatabaseCursor INTO @Database 
END 
CLOSE DatabaseCursor  
DEALLOCATE DatabaseCursor 




SELECT ps.database_id
		,ps.OBJECT_ID 
		,ps.index_id
		,b.name
		,ps.avg_fragmentation_in_percent
		
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS ps

INNER JOIN sys.indexes AS b ON ps.OBJECT_ID = b.OBJECT_ID AND ps.index_id = b.index_id

WHERE ps.database_id = DB_ID()
ORDER BY ps.OBJECT_ID



 EXEC sp_updatestats