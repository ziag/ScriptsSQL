BEGIN TRAN

/* Collation used by all the databases on a SQL Server instance */
USE Master
GO
SELECT
 NAME, 
 COLLATION_NAME
FROM sys.Databases
 ORDER BY DATABASE_ID ASC
GO

ROLLBACK