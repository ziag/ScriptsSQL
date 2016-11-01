 
 
 
WITH [PublicRoleDBPermissions]
AS (
    SELECT p.[state_desc] AS [PermissionType]
        ,p.[permission_name] AS [PermissionName]
        ,USER_NAME(p.[grantee_principal_id]) AS [DatabaseRole]
        ,CASE p.[class]
            WHEN 0
                THEN 'Database::' + DB_NAME()
            WHEN 1
                THEN OBJECT_NAME(major_id)
            WHEN 3
                THEN 'Schema::' + SCHEMA_NAME(p.[major_id])
            END AS [ObjectName]
    FROM [sys].[database_permissions] p
    WHERE p.[class] IN (0, 1, 3)
        AND p.[minor_id] = 0
    )
SELECT [PermissionType]
    ,[PermissionName]
    ,[DatabaseRole]
    ,SCHEMA_NAME(o.[schema_id]) AS [ObjectSchema]
    ,[ObjectName]
    ,o.[type_desc] AS [ObjectType]
    ,[PermissionType] + ' ' + [PermissionName] + ' ON ' + QUOTENAME(SCHEMA_NAME(o.[schema_id])) + '.' + QUOTENAME([ObjectName]) + ' TO ' + QUOTENAME([DatabaseRole]) AS [GrantPermissionTSQL]
    ,'REVOKE' + ' ' + [PermissionName] + ' ON ' + QUOTENAME(SCHEMA_NAME(o.[schema_id])) + '.' + QUOTENAME([ObjectName]) + ' TO ' + QUOTENAME([DatabaseRole]) AS [RevokePermissionTSQL]
FROM [PublicRoleDBPermissions] p
INNER JOIN [sys].[objects] o
    ON o.[name] = p.[ObjectName]
        AND OBJECTPROPERTY(o.object_id, 'IsMSShipped') = 0
WHERE [DatabaseRole] = 'Public'
ORDER BY [DatabaseRole]
    ,[ObjectName]
    ,[ObjectType]

 