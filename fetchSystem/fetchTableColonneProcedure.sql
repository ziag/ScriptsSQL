BEGIN TRAN

 
DECLARE @nt VARCHAR(50) = 'recuDon'

SELECT  DISTINCT(p.objName) AS procedureStocke
		,t.name AS nomTable 		
 		,c.name AS nomColone
		--,p.def
		
FROM    sys.tables AS t
	
INNER JOIN sys.all_columns AS c
	ON t.object_id   = c.object_id 
 
 
INNER JOIN ( SELECT DISTINCT OBJECT_NAME(OBJECT_ID) AS objName
					,OBJECT_ID
					,object_definition(OBJECT_ID) AS def
 
			FROM sys.Procedures  
			WHERE is_ms_shipped = 0  
			) AS p 
			ON  object_definition(p.OBJECT_ID) LIKE '%' + c.name + '%'
			AND object_definition(p.OBJECT_ID) LIKE '%' + t.name + '%'


 

--WHERE t.name = @nt

ORDER BY p.objName
		,t.name
		,c.name
		

  

	 	  
  
ROLLBACK