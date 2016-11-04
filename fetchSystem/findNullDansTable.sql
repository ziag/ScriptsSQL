BEGIN TRAN

DECLARE @TableName VARCHAR(200) 
SET @TableName = 'tabItem' --put your table's name here'


SELECT DISTINCT  'select ''' + syscolumns.name + ''', count (1) from ' + @TableName + ' where [' + syscolumns.name + '] is null   '
--SELECT sysobjects.*
FROM sysobjects 
INNER JOIN syscolumns 
ON sysobjects.id = syscolumns.id
WHERE (sysobjects.NAME = @TableName ) 
AND iscomputed = 0 -- do not check for computed columns
--AND uid = 5  -- Uncomment if you need to check a specifyc schema
AND syscolumns.xtype <> 189 -- do not check for timestamp columns


/*
SELECT *
FROM sys.schemas
*/
 

ROLLBACK