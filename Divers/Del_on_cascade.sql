BEGIN TRAN;

/*
DBCC CHECKIDENT ( tblEntentesCollectivesDesc, RESEED )
GO
DBCC CHECKIDENT ( tblEntentesCollectives, RESEED )
GO
*/

--ALTER TABLE tblEntentesCollectivesDesc 
--  ADD CONSTRAINT FK_id_entente 
--  FOREIGN KEY (EntenteCollectiveID) 
--  REFERENCES tblEntentesCollectives(EntenteCollectiveID) 
--  ON DELETE CASCADE;

--ALTER TABLE tblEntentesCollectivesDesc NOCHECK CONSTRAINT [EntenteCollectiveID];   --disable
--GO

--ALTER TABLE tblEntentesCollectivesDesc WITH NOCHECK CHECK CONSTRAINT [EntenteCollectiveID];  
--GO

-- enable constraint without checking existing data
 

ROLLBACK;