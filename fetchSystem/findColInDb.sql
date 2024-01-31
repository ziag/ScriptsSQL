BEGIN TRAN;

 

SELECT  
s.name AS NomSchema,
t.name AS NomTable,
	 
c.name AS NomColonne,
sCol.DATA_TYPE,
sCol.CHARACTER_MAXIMUM_LENGTH
      
	  

FROM [preprodCPAWEB].[sys].[tables] AS t
 
    INNER JOIN sys.columns AS c
        ON t.object_id = c.object_id
    INNER JOIN sys.schemas AS s
        ON t.schema_id = s.schema_id
    INNER JOIN INFORMATION_SCHEMA.COLUMNS AS sCol
        ON t.[name] = sCol.TABLE_NAME
           AND c.[name] = sCol.COLUMN_NAME
WHERE (c.name LIKE '%%')
 
AND t.name LIKE 'AutreInformations%'
ROLLBACK;