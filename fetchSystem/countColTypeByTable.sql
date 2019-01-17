/*
SELECT  *
FROM   INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_DEFINITION like '%2017%'


--intersect
 except

SELECT  *
FROM   INFORMATION_SCHEMA.ROUTINES 

WHERE ROUTINE_DEFINITION like '%SQL SVR 2017%'

ORDER BY SPECIFIC_NAME
*/

SELECT  COUNT(DATA_TYPE) AS qte, DATA_TYPE
FROM information_schema.columns 

GROUP BY DATA_TYPE;



SELECT  DISTINCT(TABLE_NAME) AS table_nvarchar
FROM information_schema.columns 
WHERE data_type = 'nvarchar';



SELECT  DISTINCT(TABLE_NAME) AS table_ntext
FROM information_schema.columns 
WHERE data_type = 'ntext';
 


SELECT  DISTINCT(TABLE_NAME) AS table_image
FROM information_schema.columns 
WHERE data_type = 'image';

 

SELECT  DISTINCT(detail.TABLE_NAME) AS nomTable
		,COUNT(DATA_TYPE) AS qte_Data_Type
		,DATA_TYPE
FROM information_schema.columns AS detail
WHERE detail.TABLE_NAME IN ( SELECT  DISTINCT(TABLE_NAME)
								FROM information_schema.columns 
								WHERE data_type = 'ntext'
								) 

GROUP BY  detail.TABLE_NAME
		  ,DATA_TYPE

ORDER BY detail.TABLE_NAME
		  ,DATA_TYPE;



SELECT  DISTINCT(TABLE_NAME), COLUMNS.COLUMN_NAME, DATA_TYPE
FROM information_schema.columns 
WHERE data_type IN ('ntext', 'image');