 
 			
BULK
INSERT   dbo.[NomDeLaTable]

FROM 'D:\TempSQL\fichier.txt'
WITH 
(
FIELDTERMINATOR = '\t',
rowterminator = '\n',
FIRSTROW = 2 

) 

 
