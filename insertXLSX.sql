 
 
--sp_configure 'show advanced options', 1;
--GO
--RECONFIGURE;
--GO
--sp_configure 'Ad Hoc Distributed Queries', 1;
--GO
--RECONFIGURE;
--GO


SELECT *
--INTO BonusUpload
FROM
OPENROWSET('Microsoft.ACE.OLEDB.12.0'
,'Excel 12.0 Xml;HDR=YES;
Database=D:\tempSQL\fichier.xlsx'
,'SELECT * FROM [Feuil1$]'
)



/*
INSERT INTO tblSample
2.
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
3.
'Excel 12.0 Xml;HDR=YES;Database=C:\Test.xlsx',
4.
'SELECT * FROM [Sheet1$]');


;.l,kmn jb
*/
 
