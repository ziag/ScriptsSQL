	
 
 
-- Save XML records to a file:
DECLARE @fileName VARCHAR(50)
 
DECLARE @sqlStr VARCHAR(1000)
DECLARE @sqlCmd VARCHAR(1000)
 
SET @fileName = 'C:\temp\data.xml'
SET @sqlStr = 'select xmldata from artisti_Sdeg.dbo.xmlSource'
 
SET @sqlCmd = 'bcp "' + @sqlStr + '" queryout ' + @fileName + ' -w -T'
 
EXEC xp_cmdshell @sqlCmd



 