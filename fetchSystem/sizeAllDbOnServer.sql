WITH fs
AS
(
    SELECT database_id, TYPE, SIZE * 8.0 / 1024 SIZE
    FROM sys.master_files
)
SELECT 
    name,
    (SELECT SUM(SIZE) FROM fs WHERE TYPE = 0 AND fs.database_id = db.database_id) DataFileSizeMB,
    (SELECT SUM(SIZE) FROM fs WHERE TYPE = 1 AND fs.database_id = db.database_id) LogFileSizeMB
FROM sys.databases db



 
