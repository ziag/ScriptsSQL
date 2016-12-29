SELECT 
 SERVERPROPERTY('BuildClrVersion') AS BuildClrVersion	--Version of the Microsoft.NET Framework common language runtime (CLR) that was used while building the instance of SQL Server.
,SERVERPROPERTY('Collation') AS Collation	--Name of the default collation for the server.
,SERVERPROPERTY('CollationID') AS CollationID	--ID of the SQL Server collation.
,SERVERPROPERTY('ComparisonStyle') AS ComparisonStyle	--Windows comparison style of the collation.
,SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS ComputerNamePhysicalNetBIOS	--NetBIOS name of the local computer on which the instance of SQL Server is currently running.
,SERVERPROPERTY('Edition') AS Edition		--Installed product edition of the instance of SQL Server. Use the value of this property to determine the features and the limits, such as Compute Capacity Limits by Edition of SQL Server. 64-bit versions of the Database Engine append (64-bit) to the version.
,SERVERPROPERTY('EditionID') AS EditionID	--EditionID represents the installed product edition of the instance of SQL Server. Use the value of this property to determine features and limits, such as Compute Capacity Limits by Edition of SQL Server.
,SERVERPROPERTY('EngineEdition') AS EngineEdition	--Database Engine edition of the instance of SQL Server installed on the server.
,SERVERPROPERTY('HadrManagerStatus') AS HadrManagerStatus		--Applies to: SQL Server 2012 through SQL Server 2016. Indicates whether the AlwaysOn Availability Groups manager has started.
,SERVERPROPERTY('InstanceDefaultDataPath') AS InstanceDefaultDataPath	--Applies to: SQL Server 2012 through current version in updates beginning in late 2015.Name of the default path to the instance data files.
,SERVERPROPERTY('InstanceDefaultLogPath') AS InstanceDefaultLogPath		--Applies to: SQL Server 2012 through current version in updates beginning in late 2015.Name of the default path to the instance data files.
,SERVERPROPERTY('InstanceName') AS InstanceName	--Name of the instance to which the user is connected.
,SERVERPROPERTY('IsAdvancedAnalyticsInstalled') AS IsAdvancedAnalyticsInstalled	--Returns 1 if the Advanced Analytics feature was installed during setup; 0 if Advanced Analytics was not installed.
,SERVERPROPERTY('IsClustered') AS IsClustered	--Server instance is configured in a failover cluster.
,SERVERPROPERTY('IsFullTextInstalled') AS IsFullTextInstalled	--The full-text and semantic indexing components are installed on the current instance of SQL Server.
,SERVERPROPERTY('IsHadrEnabled') AS IsHadrEnabled 	--Applies to: SQL Server 2012 through SQL Server 2016.AlwaysOn Availability Groups is enabled on this server instance.
,SERVERPROPERTY('IsIntegratedSecurityOnly') AS IsIntegratedSecurityOnly	--Server is in integrated security mode.
,SERVERPROPERTY('IsLocalDB') AS IsLocalDB 	--Applies to: SQL Server 2012 through SQL Server 2016.Server is an instance of SQL Server Express LocalDB.
,SERVERPROPERTY('IsPolybaseInstalled') AS IsPolybaseInstalled	--Applies to: SQL Server 2016.Returns whether the server instance has the PolyBase feature installed.
,SERVERPROPERTY('IsSingleUser') AS IsSingleUser 	--Server is in single-user mode.
,SERVERPROPERTY('IsXTPSupported') AS IsXTPSupported 	--Applies to: SQL Server (SQL Server 2014 through SQL Server 2016), SQL Database.Server supports In-Memory OLTP.
,SERVERPROPERTY('LCID') AS LCID	--Windows locale identifier (LCID) of the collation.
,SERVERPROPERTY('LicenseType') AS LicenseType 	--Unused. License information is not preserved or maintained by the SQL Server product. Always returns DISABLED.
,SERVERPROPERTY('MachineName') AS MachineName 	--Windows computer name on which the server instance is running.
,SERVERPROPERTY('NumLicenses') AS NumLicenses 	--Unused. License information is not preserved or maintained by the SQL Server product. Always returns NULL.
,SERVERPROPERTY('ProcessID') AS ProcessID 	--Process ID of the SQL Server service. ProcessID is useful in identifying which Sqlservr.exe belongs to this instance.
,SERVERPROPERTY('ProductBuild') AS ProductBuild 	--Applies to: SQL Server 2014 beginning October, 2015. The build number.
,SERVERPROPERTY('ProductBuildType') AS ProductBuildType	--Applies to: SQL Server 2012 through current version in updates beginning in late 2015. The build Type.
,SERVERPROPERTY('ProductLevel') AS ProductLevel 	--Level of the version of the instance of SQL Server.
,SERVERPROPERTY('ProductMajorVersion') AS ProductMajorVersion	--Applies to: SQL Server 2012 through current version in updates beginning in late 2015. The major version.
,SERVERPROPERTY('ProductMinorVersion') AS ProductMinorVersion	--Applies to: SQL Server 2012 through current version in updates beginning in late 2015. The minor version.
,SERVERPROPERTY('ProductUpdateLevel') AS ProductUpdateLevel	--Applies to: SQL Server 2012 through current version in updates beginning in late 2015.
,SERVERPROPERTY('ProductUpdateReference') AS ProductUpdateReference 	--Applies to: SQL Server 2012 through current version in updates beginning in late 2015.
,SERVERPROPERTY('ProductVersion') AS ProductVersion 	--Version of the instance of SQL Server, in the form of'major.minor.build.revision'.
,SERVERPROPERTY('ResourceLastUpdateDateTime') AS ResourceLastUpdateDateTime	--Returns the date and time that the Resource database was last updated.
,SERVERPROPERTY('ResourceVersion') AS ResourceVersion 	--Returns the version Resource database.
,SERVERPROPERTY('ServerName') AS ServerName 	--Both the Windows server and instance information associated with a specified instance of SQL Server.
,SERVERPROPERTY('SqlCharSet') AS SqlCharSet 	--The SQL character set ID from the collation ID.
,SERVERPROPERTY('SqlCharSetName') AS SqlCharSetName 	--The SQL character set name from the collation.
,SERVERPROPERTY('SqlSortOrder') AS SqlSortOrder 	--The SQL sort order ID from the collation
,SERVERPROPERTY('SqlSortOrderName') AS SqlSortOrderName	--The SQL sort order name from the collation.
,SERVERPROPERTY('FilestreamShareName') AS FilestreamShareName	--The name of the share used by FILESTREAM.
,SERVERPROPERTY('FilestreamConfiguredLevel') AS FilestreamConfiguredLevel	--The configured level of FILESTREAM access. For more information, see filestream access level.
,SERVERPROPERTY('FilestreamEffectiveLevel') AS FilestreamEffectiveLevel	--The effective level of FILESTREAM access. This value can be different than the FilestreamConfiguredLevel if the level has changed and either an instance restart or a computer restart is pending. For more information, see filestream access level.
GO