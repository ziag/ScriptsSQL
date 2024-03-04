SELECT 
	
    s.name + '.' + t.NAME AS TableName,
    p.rows AS RowCounts
 --   ,SUM(a.total_pages) * 8 / 1024.00 AS TotalSpaceMB,
	--SUM(a.total_pages) * 8 / (1024.00*1024.00) AS TotalSpaceGB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
INNER JOIN 
	sys.schemas  AS s ON s.schema_id = t.schema_id

WHERE   (t.NAME NOT LIKE '%_HISTO' AND t.NAME NOT LIKE 'LOG%' AND t.NAME NOT LIKE 'tmp_user') AND 

  --  t.NAME NOT LIKE 'dt%' AND
    i.OBJECT_ID > 255 AND   
    t.is_ms_shipped = 0
GROUP BY 
    s.name, t.Name, p.Rows
ORDER BY 
    --TotalSpaceMB DESC
	TableName

	 