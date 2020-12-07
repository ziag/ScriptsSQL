CREATE procedure usp_SetCompatibilityLevel

as

DECLARE @SQL VARCHAR(max)  = ''
DECLARE @CompLevel int = 140

SELECT @SQL += 'ALTER DATABASE ' + quotename(NAME) + ' SET COMPATIBILITY_LEVEL = ' + cast(@CompLevel as char (3)) + ';' + CHAR(10) + CHAR(13)
FROM sys.databases
WHERE COMPATIBILITY_LEVEL <> @CompLevel


SELECT @SQL
EXECUTE (@SQL) 
 

