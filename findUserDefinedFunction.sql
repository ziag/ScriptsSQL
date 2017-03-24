BEGIN TRAN

-- create table to hold function names
CREATE TABLE #TempFunctions(
	ID INT IDENTITY(1,1),
	fnName VARCHAR(256)
);

-- create table to hold stored procedure and function that is in it names
CREATE TABLE #spWithFn (
	ID INT IDENTITY(1,1),
	spName VARCHAR(256),
	fnName VARCHAR(256)
);
 
 -- fill the function name table
 -- FN = SQL_SCALAR_FUNCTION
 -- IF = SQL_INLINE_TABLE_VALUED_FUNCTION
 -- TF = SQL_TABLE_VALUED_FUNCTION
 INSERT #TempFunctions(fnName)
SELECT name
FROM SYS.OBJECTS WHERE TYPE IN ('FN','IF','TF')


DECLARE @fnName VARCHAR(256);
DECLARE @SQLCmd VARCHAR(512);

WHILE ((SELECT COUNT(1) FROM #TempFunctions) > 0)
BEGIN

	-- get one function
	SELECT TOP 1 @fnName = fnName FROM #TempFunctions ORDER BY fnName

	-- search all stored procedures for that function name
	SET @SQLCmd = 
	'INSERT #spWithfn(spName,fnName)
	SELECT Name, ''' + @fnName + ''' FROM sys.procedures WHERE OBJECT_DEFINITION(OBJECT_ID) LIKE ''%' + @fnName + '%'''

	EXEC(@SQLCmd);

	-- delete function from function table
	DELETE #TempFunctions
	WHERE fnName = @fnName;

END;

-- report on stored procs and number of UDFs contained
SELECT spName,COUNT(1) NumberUDFs
FROM #spWithFn
GROUP BY  spName 
ORDER BY COUNT(1) DESC;


-- Show stored proc name and function name
SELECT * FROM #spWithfn ORDER BY spName;

DROP TABLE #tempFunctions;
DROP TABLE #spWithfn;







ROLLBACK