BEGIN TRAN


exec sp_MSforeachDB 'DBCC CHECKDB (?) WITH ALL_ERRORMSGS, EXTENDED_LOGICAL_CHECKS, DATA_PURITY'


 



ROLLBACK