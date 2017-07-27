BEGIN TRAN

SELECT [Current LSN]
      ,[Operation]
      ,[Transaction ID]
      ,AllocUnitName 
      ,[Transaction Name]
      ,[Transaction SID]  
      , SUSER_SNAME([Transaction SID]) AS DBUserName
      ,[Begin Time]  
      ,[Lock Information]
FROM sys.fn_dblog(NULL,NULL)
WHERE 
	SUSER_SNAME([Transaction SID]) = 'UDA\shuard'
--AND   
	--[Transaction Name] in ('CREATE TABLE','INSERT','DELETE')


ROLLBACK