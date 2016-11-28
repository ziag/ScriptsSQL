BEGIN TRAN

SET ANSI_WARNINGS OFF
GO

DECLARE @tbl VARCHAR(100), @col VARCHAR(100), @cmd VARCHAR(MAX)

SET @tbl = 'TableName'

DECLARE curSingleValue CURSOR FOR

SELECT b.name
	FROM sys.tables a
		JOIN sys.columns b ON a.object_id = b.object_id
	WHERE a.Name = @tbl
	ORDER BY b.name

OPEN curSingleValue
FETCH NEXT FROM curSingleValue INTO @col
WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @cmd = 'IF (SELECT COUNT(DISTINCT [' + @col + ']) FROM [' + @tbl + ']) = 1 
		OR ISNULL((SELECT COUNT(DISTINCT [' + @col + ']) FROM [' + @tbl + ']), 1) = 0 
		BEGIN print ''' + @col + ''' end'
	PRINT @cmd
    EXEC(@cmd)

    FETCH NEXT FROM curSingleValue INTO @col
END
CLOSE curSingleValue
DEALLOCATE curSingleValue

SET ANSI_WARNINGS ON
GO

ROLLBACK