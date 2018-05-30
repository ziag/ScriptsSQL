-- Search in All Objects
SELECT OBJECT_NAME(OBJECT_ID),*,
definition
FROM sys.sql_modules
WHERE definition LIKE '%' + 'AuditEventTrigger_Nubik' + '%'
GO


-- Search in Stored Procedure Only
SELECT DISTINCT OBJECT_NAME(OBJECT_ID),
object_definition(OBJECT_ID)
FROM sys.Procedures
WHERE object_definition(OBJECT_ID) LIKE '%' + 'AuditEventTrigger_Nubik' + '%'
GO

  
GO  
SELECT OBJECT_ID(N'[salesforce backups].[DBO].[AuditEventTrigger_Nubik]') AS 'Object ID';  
GO


SELECT  *
FROM    DDLEvents 