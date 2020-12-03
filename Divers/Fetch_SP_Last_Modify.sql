BEGIN TRANSACTION;

SELECT 
	 [database name] = DB_NAME() 
	,[schema name] =  SCHEMA_NAME([schema_id])
	,name [stored proc name]
	,create_date [create date]
	,modify_date [last modify date]
FROM sys.objects
WHERE TYPE = 'P'
--AND name = 'uspMyFifthStoredProcedure';


ROLLBACK;