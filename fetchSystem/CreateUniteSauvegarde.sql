 
	
USE [msdb]
GO



SET NOCOUNT ON

DECLARE  @name nvarchar(50)

declare @job nvarchar(50)
declare @path nvarchar(max) 

DECLARE db_cursor CURSOR FOR 

select   name from sys.databases
where database_id > 8 or database_id  = 7
order by database_id 

OPEN db_cursor

FETCH NEXT FROM db_cursor 
INTO @name

WHILE @@FETCH_STATUS = 0
begin

	set @job = 'Path_' + @name
	print 'job ' + @job
	set @path = 'C:\Main\BackUp_' + @name + '.bak'

/*	
EXEC master.dbo.sp_dropdevice @logicalname = @job
	print  @job
-- Get the next vendor.
*/

	 EXEC master.dbo.sp_addumpdevice  @devtype = N'disk'
	, @logicalname = @job
	, @physicalname = @path
 

FETCH NEXT FROM db_cursor 
INTO @name



END 
CLOSE db_cursor
DEALLOCATE db_cursor