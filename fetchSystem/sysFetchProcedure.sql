BEGIN TRAN
/*

*/
declare @str as varchar(max) 
set @str = '%uda-sql%'

/*
SELECT c.name, * 
FROM sys.tables AS t 
INNER JOIN  sys.columns AS c ON c.object_id = t.object_id 
WHERE c.name LIKE @str

SELECT ROUTINE_NAME, ROUTINE_DEFINITION,*
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_DEFINITION LIKE @str
AND ROUTINE_TYPE  LIKE @str --='[fctGetArtisteVedette]'
*/


SELECT OBJECT_NAME(id) ,*
FROM SYSCOMMENTS 
WHERE [text] LIKE @str
AND OBJECTPROPERTY(id, 'IsProcedure') = 1 
--GROUP BY OBJECT_NAME(id)

SELECT OBJECT_NAME(object_id)
FROM sys.sql_modules
WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1
AND  OBJECT_NAME(object_id) LIKE @str

    
   /* 
SELECT OBJECT_NAME(object_id)
FROM sys.sql_modules
WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1
AND definition LIKE @str
    
     
SELECT OBJECT_NAME(object_id),*
FROM sys.sql_modules
WHERE OBJECTPROPERTY(object_id, 'IsTrigger ') = 1
AND definition LIKE @str
  */   
    
SELECT  *
FROM    sys.all_objects 
WHERE OBJECTPROPERTY(object_ID, 'IsTrigger') = 1
AND name LIKE  @str
    
  


ROLLBACK