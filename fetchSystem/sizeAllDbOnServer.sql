WITH fs
AS
(
    SELECT database_id, TYPE, SIZE * 8.0 / 1024 SIZE
    FROM sys.master_files
)
SELECT 
    name as DbName,
    (SELECT SUM(SIZE) FROM fs WHERE TYPE = 0 AND fs.database_id = db.database_id) DataFileSizeMB,
	(SELECT SUM(SIZE)/1024 FROM fs WHERE TYPE = 0 AND fs.database_id = db.database_id) DataFileSizeGo
    (SELECT SUM(SIZE) FROM fs WHERE TYPE = 1 AND fs.database_id = db.database_id) LogFileSizeMB
	,'' as Priorité
	,'' as 'À convertir' 
FROM sys.databases db



 
