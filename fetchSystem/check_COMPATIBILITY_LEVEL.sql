BEGIN TRANSACTION;

SELECT 

	CASE compatibility_level
		WHEN 80  THEN 'SQL Server 2000' 
		WHEN 90  THEN 'SQL Server 2005' 
		WHEN 100 THEN 'SQL Server 2008 et 2008 R2' 
		WHEN 110 THEN 'SQL Server 2012' 
		WHEN 120 THEN 'SQL Server 2014' 

	END AS 'compatibility_level'
	 , name  
FROM sys.databases;

ROLLBACK;