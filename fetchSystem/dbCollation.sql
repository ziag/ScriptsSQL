




DECLARE @Query varchar(1000) 
DECLARE @dbname varchar(50) 

/*
SELECT     @dbname = 'db1'

SELECT     @Query = 'Select * from ' + @dbname + '.dbo.contact' 

EXEC (@Query)
*/



declare  db   cursor
for 

select name from sys.databases order by name

open db 
fetch next from db 
into @dbname


WHILE @@FETCH_STATUS = 0
BEGIN

 
SELECT @dbname, DATABASEPROPERTYEX(@dbname, 'Collation')  SQLCollation ;-- from sys.databases



--select @Query =  'SELECT DATABASEPROPERTYEX(''' + @dbname + ''', ''Collation'')  SQLCollation ;' from sys.databases

--EXEC (@Query)

fetch next from db 
into @dbname

END

close db 
deallocate db 