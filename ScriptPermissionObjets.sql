BEGIN TRANSACTION;

DECLARE @nom VARCHAR(50) = 'CPADP'

SET NOCOUNT ON;
PRINT 'Column Level Privileges to the User:';
SELECT  
		'grant ' + PRIVILEGE_TYPE + ' on ' + TABLE_SCHEMA + '.' + TABLE_NAME + ' (' + COLUMN_NAME + ') to [' + GRANTEE
       + ']' + CASE IS_GRANTABLE
                   WHEN 'YES' THEN
                       ' With GRANT OPTION'
                   ELSE
                       ''
               END
FROM INFORMATION_SCHEMA.COLUMN_PRIVILEGES
 

PRINT 'Table Level Privileges to the User:';
SELECT	 
	  'grant ' + PRIVILEGE_TYPE + ' on ' + TABLE_SCHEMA + '.' + TABLE_NAME + ' to [' + GRANTEE + ']'
       + CASE IS_GRANTABLE
             WHEN 'YES' THEN
                 ' With GRANT OPTION'
             ELSE
                 ''
         END
FROM INFORMATION_SCHEMA.TABLE_PRIVILEGES
WHERE GRANTEE = @nom

PRINT 'Privileges for Procedures/Functions to the User:';
SELECT   

		'grant execute on ' + c.name + '.' + a.name + ' to ' + USER_NAME(b.grantee_principal_id)
       + CASE state
             WHEN 'W' THEN
                 ' with grant option'
             ELSE
                 ''
         END
		 ,b.*
FROM sys.all_objects a,
     sys.database_permissions b,
     sys.schemas c
WHERE a.object_id = b.major_id
      AND a.type IN ( 'P', 'FN' )
      AND b.grantee_principal_id <> 0
      AND b.grantee_principal_id <> 2
      AND a.schema_id = c.schema_id
	  AND b.grantee_principal_id = 6
 


ROLLBACK;