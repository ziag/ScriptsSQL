BEGIN TRAN

SELECT *--SUBSTRING(physical_name, 1,
--CHARINDEX(N'master.mdf',
--LOWER(physical_name)) - 1) DataFileLocation
FROM master.sys.master_files
WHERE database_id = 1 AND FILE_ID = 1

ROLLBACK