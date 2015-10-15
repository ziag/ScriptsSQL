
/*
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

-- delete data in all tables
EXEC sp_MSForEachTable "DELETE FROM ?"

-- enable all constraints
exec sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"


--if some of the tables have identity columns we may want to reseed them

EXEC sp_MSforeachtable "DBCC CHECKIDENT ( '?', RESEED, 0)"


*/