BEGIN TRAN

USE master;
SELECT d.name , 
   f.name 'Logical Name', 
  physical_name 'File Location', *
FROM sys.master_files as  f
INNER JOIN  sys.databases   as d 
	on f.database_id = d.database_id 
 
 

ROLLBACK