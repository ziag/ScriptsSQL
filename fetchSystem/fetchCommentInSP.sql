BEGIN TRAN

 SELECT Distinct SO.Name
 FROM sysobjects SO (NOLOCK)
 INNER JOIN syscomments SC (NOLOCK) on SO.Id = SC.ID
 -- AND SO.Type = 'P'
 AND SC.Text LIKE '%uda-sql%'
 ORDER BY SO.Name

ROLLBACK