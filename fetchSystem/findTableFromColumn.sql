SELECT  COUNT(DATA_TYPE) as qte, DATA_TYPE
FROM information_schema.columns 

GROUP BY DATA_TYPE



SELECT  distinct(TABLE_NAME)
FROM information_schema.columns 
WHERE data_type = 'nvarchar'



SELECT  distinct(TABLE_NAME)
FROM information_schema.columns 
WHERE data_type = 'ntext'
 


SELECT  distinct(TABLE_NAME)
FROM information_schema.columns 
WHERE data_type = 'image'




SELECT  distinct(detail.TABLE_NAME) as nomTable
		,COUNT(DATA_TYPE) as qte_Data_Type
		,DATA_TYPE
FROM information_schema.columns as detail
WHERE detail.TABLE_NAME in ( SELECT  distinct(TABLE_NAME)
								FROM information_schema.columns 
								WHERE data_type = 'ntext'
								) 

GROUP BY DATA_TYPE