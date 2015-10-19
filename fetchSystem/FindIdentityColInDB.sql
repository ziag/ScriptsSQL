SELECT         
               t.TABLE_NAME
              ,c.COLUMN_NAME
              ,c.TABLE_CATALOG
              ,c.TABLE_SCHEMA 
FROM         
              INFORMATION_SCHEMA.COLUMNS AS c JOIN
              INFORMATION_SCHEMA.TABLES AS t
                      ON t.TABLE_NAME = c.TABLE_NAME
WHERE         
               COLUMNPROPERTY(OBJECT_ID(c.TABLE_NAME)
                      ,c.COLUMN_NAME,'IsIdentity') = 1 AND
               t.TABLE_TYPE = 'Base Table' AND
               t.TABLE_NAME NOT LIKE 'dt%' AND
               t.TABLE_NAME NOT LIKE 'MS%' AND
               t.TABLE_NAME NOT LIKE 'syncobj_%' 