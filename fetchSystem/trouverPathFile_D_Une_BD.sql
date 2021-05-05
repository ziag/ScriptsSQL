BEGIN TRAN


SELECT d.name DatabaseName,
       f.name LogicalName,
       f.size,
       f.physical_name AS PhysicalName,
       f.type_desc TypeofFile,
	   d.recovery_model_desc
FROM sys.master_files f
    INNER JOIN sys.databases d
        ON d.database_id = f.database_id;
GO

 


ROLLBACK