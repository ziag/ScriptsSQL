
/*

je pense que je comprend

*/

--EXEC isp_RepairDB @SearchDBName = 'FDA',@DBCCOption = 'REPAIR_ALLOW_DATA_LOSS'
/*
The first parameter is the name of the database that you want to repair. The second is the level of repair that you want DBCC to do, refer to book online for the three different settings.

Also, keep in mind this WILL take you database offline for the duration of the repair.

Here is the code that you will need to commit to any database on your server.

*/

Create Procedure isp_RepairDB@SearchDBName sysname,@DBCCOption sysname
AS

Begin
Declare @SPID int,@DBName nvarchar(255)

Create table #SPIDS (SPID int,ecid int,status varchar(255),loginame varchar(255) ,hostname varchar(255),blk int,dbname nvarchar(255),cmd varchar(255))

Insert into #SPIDS
EXEC('sp_who') Print 'Killing Connections'

Declare curWho cursor
for Select dbname,spid From #SPIDS

Open curWho

Fetch Next From curWho into @DBName,@SPID
While @@FETCH_STATUS = 0
Begin
If @DBName = cast(@SearchDBName as varchar(255))
Begin
Declare @SQL varchar(255)
Set @SQL = 'Kill ' + cast(@SPID as varchar(5)) + ''
Print @SQL
Print @SearchDBName
EXEC(@SQL)
End
Fetch Next From curWho into @DBName,@SPID
End
Close curWho
Deallocate curWho
Drop Table #SPIDS
Print 'Connections Dead'
EXEC sp_dboption @dbname = @SearchDBName,@optname ='single user',@optvalue = 'true'
Print 'SINGLE USER MODE SET'
Declare @DBCCSQL as varchar(255)
Set @DBCCSQL = 'DBCC CHECKDB(' + @SearchDBName + ',' + @DBCCOption + ')'
Print @DBCCSQL
EXEC(@DBCCSQL)
EXEC sp_dboption @dbname = @SearchDBName,@optname ='single user',@optvalue = 'false'
Print 'SINGLE USER MODE UNSET'
End
