--Create a table for the outdated statistics
 

CREATE TABLE Outdated_statistics
([Table name] sysname,
[Index name] sysname,
[Last updated] datetime NULL,
[Rows modified] int NULL)
GO
 
 /**/
 -- EXECUTE sp_updatestats 
/*
Now we will query every statistics object which was not updated in the 
  last day and has rows modified since the last update. We will use the 
  rowmodctr field of sys.sysindexes because it shows how many rows were 
  inserted, updated or deleted since the last update occurred. Please 
  note that it is not always 100% accurate in SQL Server 2005 and later, 
  but it can be used to check if any rows were modified.
*/

--Get the list of outdated statistics
-- INSERT INTO Outdated_statistics
SELECT OBJECT_NAME(id),name,STATS_DATE(id, indid),rowmodctr
FROM sys.sysindexes
WHERE STATS_DATE(id, indid)<=DATEADD(DAY,-1,GETDATE()) 
AND rowmodctr>0 
AND id IN (SELECT object_id FROM sys.tables)
GO
 
 --exec sp_updatestats

--After collecting this information, we can decide which statistics require an update.

--If we are sure that all out dated statistics should be immediately updated, then we can write a cursor to update them:

--Set the thresholds when to consider the statistics outdated

/*
DECLARE @hours int
DECLARE @modified_rows int
DECLARE @update_statement nvarchar(300);

SET @hours=24
SET @modified_rows=10

--Update all the outdated statistics
DECLARE statistics_cursor CURSOR FOR
SELECT 'UPDATE STATISTICS '+OBJECT_NAME(id)+' '+name
FROM sys.sysindexes
WHERE STATS_DATE(id, indid)<=DATEADD(HOUR,-@hours,GETDATE()) 
AND rowmodctr>=@modified_rows 
AND id IN (SELECT object_id FROM sys.tables)
 
OPEN statistics_cursor;
FETCH NEXT FROM statistics_cursor INTO @update_statement;
 
 WHILE (@@FETCH_STATUS <> -1)
 BEGIN
  EXECUTE (@update_statement);
  PRINT @update_statement;
 
 FETCH NEXT FROM statistics_cursor INTO @update_statement;
 END;
 
 PRINT 'The outdated statistics have been updated.';
CLOSE statistics_cursor;
DEALLOCATE statistics_cursor;
GO
 
 
 
 drop table Outdated_statistics
 
 */