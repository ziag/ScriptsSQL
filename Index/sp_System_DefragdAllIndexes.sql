USE [UDA_Axiant]
GO
/****** Object:  StoredProcedure [dbo].[SP_System_DefragdAllIndexes]    Script Date: 06/16/2015 09:06:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 ALTER PROCEDURE [dbo].[SP_System_DefragdAllIndexes]
 /*
 Permet de défragmentation des Indexes
 de toutes les bases du serveur SQL Server
 */

 AS

 DECLARE @name sysname
 DECLARE @Objectname sysname
 DECLARE @Username sysname
 DECLARE @IndexName sysname
 DECLARE @LaRequette varchar(8000)
 DECLARE @DateJour varchar(20)

 SET @DateJour = REPLACE(CONVERT(VARCHAR, GetDate(), 102), '.', '_')
 PRINT '---------------------------------------------------------------------'
 PRINT ' DATE DE LA MISE A JOUR DES INDEXES LANCEE : '+ @DateJour
 PRINT '---------------------------------------------------------------------'

 DECLARE TESTCURSEUR CURSOR
 FOR SELECT Master.dbo.sysdatabases.name FROM Master.dbo.sysdatabases
 WHERE Master.dbo.sysdatabases.name NOT IN ('tempdb', 'model', 'pubs', 'master', 'msdb', 'LVM')
 ORDER BY Master.dbo.sysdatabases.name

 OPEN TESTCURSEUR
 FETCH NEXT FROM TESTCURSEUR
 INTO @name

 WHILE @@FETCH_STATUS = 0

 BEGIN
 PRINT ''
 PRINT '---------------------------------------------------------------------'
 PRINT ' DEFRAGMENTATION DES INDEXES DE LA BASE : '+ @name
 PRINT '---------------------------------------------------------------------'

 SET @LaRequette = 'SELECT USR.name AS UserName, O.name AS Objectname, IDX.name IndexName
 FROM '+ @name +'.dbo.sysobjects O INNER JOIN '+ @name +'.dbo.sysusers USR
 ON O.uid = USR.uid INNER JOIN '+ @name +'.dbo.sysindexes IDX
 ON O.id = IDX.id WHERE (O.xtype= ''U'' OR O.xtype= ''V'')
 AND NOT (IDX.keys IS NULL) AND NOT (IDX.status & 64 = 64);'

 PRINT 'Changement de base : '+ @LaRequette
 PRINT '---------------------------------------------------------------------'

 EXEC('DECLARE TESTCURSEURTABLE CURSOR FOR '+ @LaRequette)
 OPEN TESTCURSEURTABLE
 FETCH NEXT FROM TESTCURSEURTABLE
 INTO @Username, @Objectname, @IndexName

 WHILE @@FETCH_STATUS = 0
 BEGIN
 SET @LaRequette = 'DBCC INDEXDEFRAG ('''+ @name +''', '''+ @Username+'.'+ @Objectname +''', '''+ @IndexName +''')'
 PRINT 'Requette : '+ @LaRequette
 EXECUTE (@LaRequette)
 PRINT '---------------------------------------------------------------------'
 FETCH NEXT FROM TESTCURSEURTABLE
 INTO @Username, @Objectname, @IndexName
 END

 CLOSE TESTCURSEURTABLE
 DEALLOCATE TESTCURSEURTABLE

 SET @LaRequette = 'USE '+ @name +' exec sp_updatestats'
 PRINT 'Requette : '+ @LaRequette
 EXECUTE (@LaRequette)

 FETCH NEXT FROM TESTCURSEUR
 INTO @name
 END

 PRINT '---------------------------------------------------------------------'
 PRINT ' FIN DE LA DEFRAGMENTATION											 '
 PRINT '---------------------------------------------------------------------'

 CLOSE TESTCURSEUR
 DEALLOCATE TESTCURSEUR


