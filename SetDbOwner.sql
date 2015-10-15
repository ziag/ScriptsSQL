 
 
use UDA_Axiant
GO 

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = 'administrator')
BEGIN
	SELECT 'DROP USER'
	DROP USER  [administrator]
END 

EXEC sp_changedbowner 'administrator'


SELECT SUSER_SNAME(owner_sid), sys.databases.name  FROM sys.databases


 

 
SELECT s.name
FROM sys.schemas s
WHERE s.principal_id = USER_ID('administrator');


 