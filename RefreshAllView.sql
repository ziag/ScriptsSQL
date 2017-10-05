 

-----------------------------------------------------------------------------
-- REFRESH ALL VIEWS
-----------------------------------------------------------------------------
SET NOCOUNT ON;
DECLARE @SQL VARCHAR(MAX) = '';
SELECT @SQL = @SQL + 'print ''Refreshing --> ' + name + '''
EXEC sp_refreshview ' + name + ';
'
  FROM sysobjects 
  WHERE TYPE = 'V' 
  --AND name LIKE 'v%';  --< condition to select all views, may vary by your standards
SELECT @SQL;
EXECUTE(@SQL);
go

 