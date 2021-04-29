BEGIN TRAN;




SELECT t.*
	   ,c.*

FROM sys.tables AS t
    INNER JOIN sys.columns AS c
        ON t.object_id = c.object_id
WHERE c.name LIKE '%dispen%';


ROLLBACK;