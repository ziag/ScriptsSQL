
Create Procedure isp_CheckServerForCorruption
AS
Begin
Declare @DBName sysname,@Message varchar(255)
Declare curDatabases cursor
for select [name] from master..sysdatabases
Open curDatabases
fetch next from curDatabases into @DBName
While @@FETCH_STATUS = 0
Begin Set @Message = '*****BEGIN Processing ' + @DBNAME + '********'
print @Message
declare @SQL varchar(255)
Set @SQL = 'DBCC CHECKDB(' + @DBName + ') with PHYSICAL_ONLY'
EXEC (@SQL)
Set @Message = '*****END Processing ' + @DBNAME + '********'
print @Message
fetch next from curDatabases into @DBName
End
Close curDatabases
Deallocate curDatabases
End

After running this procedure you will see two types of output, for databases that are ok and have no corruption you will get;

*****BEGIN Processing YOURDB********
DBCC results for 'YOURDB'.CHECKDB found 0 allocation errors and 0 consistency errors in database 'YOURDB'.DBCC execution completed.
If DBCC printed error messages, contact your system administrator.
*****END Processing YOURDB********

If you do get errors on a particular database you will get something similar to the following;

*****BEGIN Processing YOURDB********
Server: Msg 8904, Level 16, State 1,
Line 1 Extent (1:420048) in database ID 19 is allocated by more than one allocation object.
Server: Msg 8913, Level 16, State 1,
Line 1Extent (1:420048) is allocated to 'YOURTABLE' and at least one other object.
*****END Processing YOURDB********